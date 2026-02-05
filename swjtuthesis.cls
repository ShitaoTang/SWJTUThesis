%
% Copyright (C) 2026
%
% Original Author Limin HUANG.
% 2015/01/30		v0.0, Begin of the projet, 		@Chengdu China
% 2015/12/08		v1.0, Release of the projet, 	@Grenoble, France
% 2020/06/01		v2.0, Revision by Hao WANG, 	@Chengdu, China
% 2024/08/10		v3.0, Revision by Pungjay, 	    @Chengdu, China
% 2026/02/03        v4.0, Revision by Shitao Tang,  @Chengdu, China
%
% This version introduces significant changes compared with the previous
% release. Nevertheless, it remains partially based on earlier versions of
% the template. This work is intended as an acknowledgment of and a tribute
% to the contributions of the previous authors. 
%
% Official thesis template:
% https://gsnews.swjtu.edu.cn/info/1967/25444.htm
%
% This file may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3c
% of this license or (at your option) any later version.
% The latest version of this license is in
%    https://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2008 or later.
%

\NeedsTeXFormat{LaTeX2e}[2017/04/15]
\newcommand\swjtuthesisversion{0.2.1}
\ProvidesClass{swjtuthesis}[2026/02/02 v\swjtuthesisversion SWJTU Thesis Template]

% 检查编译引擎，必须用XeLaTeX或LuaLaTeX
\RequirePackage{iftex}
\ifXeTeX\else
  \ifLuaTeX\else
    \ClassError{swjtuthesis}{XeLaTeX or LuaLaTeX is required.}{}
  \fi
\fi

% 处理选项
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=swjtu, prefix=swjtu@, setkeys=\kvsetkeys}

%% 定义输出模式：print或electronic
\DeclareStringOption[electronic]{output} %% 默认电子分发版
\DeclareStringOption[Master]{degree} %% 默认硕士
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessKeyvalOptions*

\def\swjtu@output@print{print}
\def\swjtu@output@electronic{electronic}

\ifx\swjtu@output\swjtu@output@print
  %% 打印版，存在空白页，章节第一页在右边（奇数页），超链接为黑色
  \PassOptionsToClass{openright,twoside}{ctexbook}
  \typeout{SWJTU-Thesis: Print mode selected. Blank pages will be inserted for double-sided printing.}
\else
  %% 电子分发版，无空白页，超链接有颜色和方框
  \PassOptionsToClass{openany,oneside}{ctexbook}
  \typeout{SWJTU-Thesis: Electronic mode selected. No blank pages.}
\fi

%% 学位选项
\newcommand{\swjtu@chdegree}{}
\def\swjtu@degree@master{Master}
\def\swjtu@degree@doctor{Doctor}
\ifx\swjtu@degree\swjtu@degree@doctor
  %% 博士 (Doctor)
  \renewcommand{\swjtu@chdegree}{博士}
\else
  %% 默认为硕士 (Master)
  \renewcommand{\swjtu@chdegree}{硕士}
\fi

%% 在正文中使用"\swjtudegree{}"命令可渲染出学位
\newcommand{\swjtudegree}{\swjtu@chdegree}

\LoadClass[
  a4paper,
  UTF8,
  zihao=-4,
  scheme=chinese
]{ctexbook}

\RequirePackage{geometry}
\geometry{
  a4paper,
  top=3.0cm,
  bottom=3.9cm, %% 学校论文模板的坑，页码后面还有个换行强行抬高底部间距
  left=3.0cm,
  right=3.0cm,
  headsep=0.3cm,
  footskip=1.0cm
}
\RequirePackage[normalem]{ulem}

% 字体设置
%% 中文字体
\RequirePackage{fontspec}

\newcommand{\swjtu@fontpath}{font/}

\setCJKmainfont[
  Path = \swjtu@fontpath,
  ItalicFont = {KaiTi.ttf},
  AutoFakeBold = 3.50
]{SimSun.ttf}

%% 英文字体
\IfFontExistsTF{Times New Roman}{
  \setmainfont{Times New Roman}[
    Ligatures=TeX,
    BoldFont={Times New Roman Bold},
    ItalicFont={Times New Roman Italic},
    BoldItalicFont={Times New Roman Bold Italic}
  ]
}{
  \setmainfont{Times}[Ligatures=TeX]
}

%% 衬线字体
\setsansfont{Arial}[Ligatures=TeX]

%% 等宽字体
\IfFontExistsTF{Courier New}{
  \setmonofont{Courier New}[Scale=MatchLowercase]
}{
  \setmonofont{Menlo}[Scale=MatchLowercase]
}

%% 数学字体
\RequirePackage{unicode-math}
\RequirePackage{amsmath}
\RequirePackage{siunitx}

\IfFontExistsTF{XITS Math}{
  \setmathfont{XITS Math}
  \typeout{SWJTU-Thesis: Using XITS Math as math font.}
}{
  \IfFontExistsTF{XITSMath-Regular.otf}{
    \setmathfont{XITSMath-Regular.otf}
    \typeout{SWJTU-Thesis: Using XITS Math as math font.}
  }{
    \setmathfont{TeX Gyre Termes Math}
    \typeout{SWJTU-Thesis: Using TeX Gyre Termes Math as fallback math font.}
  }
}

% 行距设置
\RequirePackage{setspace}
\RequirePackage[normalem]{ulem} %% 下划线

\renewcommand\normalsize{%
  \@setfontsize\normalsize{12bp}{20bp}%% 字号12bp(小四), 行距20bp
  \setlength{\baselineskip}{20bp}%
  %% 公式间距微调
  \setlength{\abovedisplayskip}{6bp plus 2bp minus 2bp}%
  \setlength{\abovedisplayshortskip}{6bp plus 2bp minus 2bp}%
  \setlength{\belowdisplayskip}{6bp plus 2bp minus 2bp}%
  \setlength{\belowdisplayshortskip}{6bp plus 2bp minus 2bp}%
}

\AtBeginDocument{%
  \normalsize
  \setlength{\baselineskip}{20bp}%
}

% 封面
\newcommand\swjtu@secretlevel{公开}
\newcommand\swjtu@secretyear{}
\newcommand\swjtu@udc{}
\newcommand\swjtu@ci{}
\newcommand\swjtu@schoolcode{10613} %% 交大代码
\newcommand\swjtu@title{}
\newcommand\swjtu@entitle{}
\newcommand\swjtu@author{}
\newcommand\swjtu@enauthor{}
\newcommand\swjtu@studentid{}
\newcommand\swjtu@advisor{}
\newcommand\swjtu@enadvisor{}
\newcommand\swjtu@major{}
\newcommand\swjtu@enmajorFirst{}
\newcommand\swjtu@enmajorSecond{}
\newcommand\swjtu@schoolname{}
\newcommand\swjtu@enschoolnameFirst{}
\newcommand\swjtu@enschoolnameSecond{}
\newcommand\swjtu@date{\the\year 年 \the\month 月 \the\day 日}
\newcommand\swjtu@endate{\today}

\newcommand\secretlevel[2]{\renewcommand\swjtu@secretlevel{#1}\renewcommand\swjtu@secretyear{#2}}
\newcommand\ci[1]{\renewcommand\swjtu@ci{#1}}
\newcommand\udc[1]{\renewcommand\swjtu@udc{#1}}
\renewcommand\title[2]{\renewcommand\swjtu@title{#1}\renewcommand\swjtu@entitle{#2}}
\renewcommand\author[2]{\renewcommand\swjtu@author{#1}\renewcommand\swjtu@enauthor{#2}}
\newcommand\advisor[2]{\renewcommand\swjtu@advisor{#1}\renewcommand\swjtu@enadvisor{#2}}
\newcommand\major[3]{\renewcommand\swjtu@major{#1}\renewcommand\swjtu@enmajorFirst{#2}\renewcommand\swjtu@enmajorSecond{#3}}
\newcommand\school[3]{\renewcommand\swjtu@schoolname{#1}\renewcommand\swjtu@enschoolnameFirst{#2}\renewcommand\swjtu@enschoolnameSecond{#3}}
\newcommand\studentid[1]{\renewcommand\swjtu@studentid{#1}}
\renewcommand\date[2]{\renewcommand\swjtu@date{#1}\renewcommand\swjtu@endate{#2}}

% 下划线填空
\newcommand\swjtu@fillinblank[2]{\underline{\makebox[#1][c]{#2}}}

% checkbox
\newcommand{\swjtu@checkbox}[1][0.3ex]{\hspace{1pt}\raisebox{0.6ex}{\fbox{\rule{0pt}{#1}\rule{#1}{0pt}}}}

% 封面生成命令 (MakeCover)
\newcommand\makecover{%
  \newgeometry{top=2.54cm, bottom=2.54cm, left=2.6cm, right=2.6cm}
  \begin{titlepage}
    \pagestyle{empty}
    
    \begin{flushleft}
      {
        \zihao{-4}\songti
        \begin{spacing}{1.5}
          {中国图书分类号}\swjtu@fillinblank{7.5em}{\swjtu@ci} \hfill {密级}\swjtu@fillinblank{8.5em}{\swjtu@secretlevel \swjtu@secretyear} \par
          {国际图书分类号}\swjtu@fillinblank{7.5em}{\swjtu@udc} \hfill {单位代码~~~~}\swjtu@fillinblank{5.5em}{\swjtu@schoolcode}
        \end{spacing}
      }
    \end{flushleft}
    
    \vspace{30pt}
    
    \begin{center}
      {\zihao{1}\heiti 西\hspace{0.5em}南\hspace{0.5em}交\hspace{0.5em}通\hspace{0.5em}大\hspace{0.5em}学 \par} 
      {\zihao{2} 硕\hspace{0.5em}士\hspace{0.5em}学\hspace{0.5em}位\hspace{0.5em}论\hspace{0.5em}文 \par}
    \end{center}
    
    \vspace{56pt}
    
    \begin{center}
      {\zihao{-2}\heiti \underline{\swjtu@title} \par}
    \end{center}
    
    \vspace{54pt}
    \begin{center}
      \zihao{3}
      \linespread{1.8}\selectfont 
      \begin{minipage}{12cm} 
        \centering                
        \textbf{\makebox[6em][s]{学科专业}} \swjtu@fillinblank{10em}{\swjtu@major} \par
        \textbf{\makebox[6em][s]{学\hfill 号}} \swjtu@fillinblank{10em}{\swjtu@studentid} \par
        \textbf{\makebox[6em][s]{作者姓名}} \swjtu@fillinblank{10em}{\swjtu@author} \par
        \textbf{\makebox[6em][s]{指导教师}} \swjtu@fillinblank{10em}{\swjtu@advisor} \par
        \textbf{\makebox[6em][s]{学\hfill 院}} \swjtu@fillinblank{10em}{\swjtu@schoolname} \par
      \end{minipage}
    \end{center}
            
    \vspace{80pt}
    \begin{center}
      {\zihao{3}\songti \swjtu@date \par}
    \end{center}
    \clearpage
    
    %% === 英文封面 ===
    \thispagestyle{empty}
      \begin{center}
        \vspace*{10.5pt}
        {\zihao{4} \textbf{A Thesis Submitted to}} \\[0.5\baselineskip]
        {\zihao{4} \textbf{Southwest Jiaotong University for Master Degree}}

        \vspace{76pt}
        {\zihao{2}\bfseries \swjtu@entitle \par}

        \vspace{60pt}
        \begin{center}
        \zihao{3}
        \linespread{1.8}\selectfont 
        \begin{minipage}{12cm} 
          \centering                
          \makebox[6em][r]{Discipline~} \swjtu@fillinblank{11em}{\swjtu@enmajorFirst} \par
        \ifx\swjtu@enmajorSecond\@empty \else
          \makebox[6em][r]{} \swjtu@fillinblank{11em}{\swjtu@enmajorSecond} \par
        \fi
          \makebox[6em][r]{Student ID~} \swjtu@fillinblank{11em}{\swjtu@studentid} \par
          \makebox[6em][r]{Author~}     \swjtu@fillinblank{11em}{\swjtu@enauthor} \par
          \makebox[6em][r]{Supervisor~} \swjtu@fillinblank{11em}{\swjtu@enadvisor} \par
          \makebox[6em][r]{School~}     \swjtu@fillinblank{11em}{\swjtu@enschoolnameFirst} \par
        \ifx\swjtu@enschoolnameSecond\@empty \else
          \makebox[6em][r]{} \swjtu@fillinblank{11em}{\swjtu@enschoolnameSecond} \par
        \fi
        \end{minipage}
      \end{center}

      \vfill
      {\zihao{3} \swjtu@endate \par}
      \vspace{16pt}
    \end{center}
  \end{titlepage}
  \restoregeometry
}

% 独创性声明与授权页 (Declaration)
% 除非学校统一调整，否则此处文本不能修改
\newcommand\makedeclaration{%
  \newpage
  \thispagestyle{empty}
  \begin{center}
    {\zihao{3}\heiti 西南交通大学 \par}
    {\zihao{3}\heiti 学位论文独创性声明 \par}
  \end{center}
  \vspace{0.3cm}
  
  {\zihao{-4} \linespread{1.625}\selectfont
  本人郑重声明：所呈交的学位论文是本人在导师指导下进行的研究工作及取得的研究成果。据我所知，除了文中特别加以标注和致谢的地方外，论文中不包含其他人已经发表或撰写过的研究成果，也不包含为获得西南交通大学或其它教育机构的学位或证书而使用过的材料。其他人员对本研究所做的任何贡献均已在论文中作了明确的说明并表示谢意。
  \par}
  \vspace{0.5em}
  {\zihao{-4}\linespread{1.625}\selectfont
  本学位论文的主要创新点如下：
  \par}

  \vspace{0.5em}
  {\zihao{-4}\linespread{1.625}\selectfont
  1. 主要创新点一；
  \par}

  \vspace{0.5em}
  {\zihao{-4}\linespread{1.625}\selectfont
  2. 主要创新点二；
  \par}

  \vfill
  {\zihao{-4}
  \noindent
  \makebox[\textwidth][r]{%
  作者签名：\underline{\makebox[8em]{}}\hspace{2em}%
  }\\[\baselineskip]
  \makebox[\textwidth][r]{%
  日期：\ \qquad 年\hspace{1.5em} 月\hspace{1.5em} 日 \hspace{2em}%
  }
  \par}

  % 根据创新点长度修改这里的垂直间距
  \vspace{6cm}
  
  \newpage
  \thispagestyle{empty}
  
  \begin{center}
    {\zihao{3}\heiti 西南交通大学 \par}
    {\zihao{3}\heiti 学位论文使用授权 \par}
  \end{center}
  \vspace{0.3cm}
  
  {\zihao{-4} \linespread{1.625}\selectfont
  本学位论文作者完全了解西南交通大学有关保留、使用学位论文的规定，同意学校有权保留并向国家有关部门或机构送交论文的复印件和电子版，允许论文被查阅。本人授权西南交通大学可以将学位论文的全部或部分内容编入有关数据库进行检索及下载，可以采用影印、缩印、扫描等复制手段保存、汇编本学位论文。
  \par}
  
  \vspace{1.5em}
  {\zihao{-4}\linespread{1.625}\selectfont
  \indent 本学位论文属于 \\
  \indent 1．保密\swjtu@checkbox，在\hspace{1.5em}年解密后适用本授权书；\\
  \indent 2．不保密\swjtu@checkbox，使用本授权书。\\
  \indent（请在以上方框内打“√”）
  \par}
  
  \vspace{1.5em}
  {\zihao{-4}\linespread{1.625}\selectfont
  \indent
  作者签名：\underline{\makebox[11em]{}} \hfill 导师签名：\underline{\makebox[11em]{}} \\[0.5\baselineskip]
  \makebox[\textwidth][r]{%
  日期：\ \qquad 年\hspace{1.5em} 月\hspace{1.5em} 日 \hspace{3.5em}%
  }
  \par}
  \clearpage
}

\ctexset{
  % 一级标题（章节）
  chapter = {
    format = \centering\zihao{-3}\heiti,
    number = \arabic{chapter},
    aftername = {\quad},
    beforeskip = 4pt,
    afterskip = 18pt,
  },
  % 二级标题
  section = {
    format = \raggedright\zihao{4}\heiti,
    aftername = {\quad},
    beforeskip = 18pt,
    afterskip = 6pt,
  },
  % 三级标题
  subsection = {
    format = \raggedright\zihao{4}\heiti,
    aftername = {\quad},
    beforeskip = 12pt,
    afterskip = 6pt,
  },
  % 四级标题
  subsubsection = {
    format = \raggedright\zihao{-4}\heiti,
    indent = 2em,
    beforeskip = 12pt,
    afterskip = 6pt,
  }
}

% 页眉页脚
\RequirePackage{fancyhdr}
%% 页眉线为单横线，线宽0.75磅
\renewcommand{\headrulewidth}{0.75pt}
\newcommand{\swjtu@fancyfoot}{%
  \zihao{-5}\thepage\vspace{\baselineskip}%
}

%% 中文摘要页眉页脚
\newcommand{\chabstractmark}{%
  \pagestyle{fancy}%
  \fancyhf{}%
  \fancyhead[C]{\zihao{-5}\songti 摘\quad 要}%
  \fancyfoot[C]{\swjtu@fancyfoot}%
  \fancypagestyle{plain}{\pagestyle{fancy}}%
}

%% 英文摘要页眉页脚
\newcommand{\enabstractmark}{%
  \pagestyle{fancy}%
  \fancyhf{}%
  \fancyhead[C]{\zihao{-5} ABSTRACT}%
  \fancyfoot[C]{\swjtu@fancyfoot}%
  \fancypagestyle{plain}{\pagestyle{fancy}}%
}

%% 目录页眉页脚
\newcommand{\contentmark}{%
  \pagestyle{fancy}%
  \fancyhf{}%
  \fancyhead[C]{\zihao{-5} \leftmark}%
  \fancyfoot[C]{\swjtu@fancyfoot}%
  \fancypagestyle{plain}{\pagestyle{fancy}}%
}%

%% 主要符号表页眉页脚
\newcommand{\symbolmark}{%
  \pagestyle{fancy}%
  \fancyhf{}%
  \fancyhead[C]{\zihao{-5} 主要符号表}%
  \fancyfoot[C]{\swjtu@fancyfoot}%
  \fancypagestyle{plain}{\pagestyle{fancy}}%
}

%% 缩略词表页眉页脚
\newcommand{\abbreviationmark}{%
  \pagestyle{fancy}%
  \fancyhf{}%
  \fancyhead[C]{\zihao{-5} 缩略词表}%
  \fancyfoot[C]{\swjtu@fancyfoot}%
  \fancypagestyle{plain}{\pagestyle{fancy}}%
}

%% 正文页眉页脚
\newcommand{\mainmark}{%
  \pagestyle{fancy}%
  \fancyhf{}%
  \fancyhead[C]{\zihao{-5} 西南交通大学\swjtu@chdegree 学位论文}%
  \fancyfoot[C]{\swjtu@fancyfoot}%
  \fancypagestyle{plain}{\pagestyle{fancy}}%
}

% 空白页
\let\swjtu@cleardoublepage\cleardoublepage
\renewcommand{\cleardoublepage}{%
  \clearpage%
  %% 只有在 twoside (print) 模式下才执行判断
  \if@twoside
    \ifodd\c@page
      %% 奇数页，无需操作
    \else
      %% 偶数页，插入空白页，并清除页眉页脚
      \thispagestyle{empty}%%
      \hbox{}%%
      \newpage%
    \fi
  \fi
}

% 参考文献
\RequirePackage[bookmarksnumbered,pdfstartview=XYZ]{hyperref}
%% 超链接
\ifx\swjtu@output\swjtu@output@print
  %% 打印版，全黑，无边框
  \hypersetup{hidelinks}
\else
  %% 电子分发版默认配置
\fi

%% 顺序编码制
\RequirePackage[numbers,sort&compress,square]{natbib}
%% 上标，使用命令"\upcaite{...}"
\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}}
\renewcommand{\bibfont}{\zihao{5}\linespread{1.4}\selectfont}
\setlength{\bibsep}{4bp}
\renewcommand\bibsection{%
  \chapter*{参考文献}%% 生成不带编号的章标题
  \addcontentsline{toc}{chapter}{参考文献}%% 添加到目录
}

\setlength{\labelwidth}{1.6em} %% 编号盒子宽度
\setlength{\labelsep}{7pt}     %% 编号与正文的间距
\setlength{\leftmargin}{\labelwidth}
\addtolength{\leftmargin}{\labelsep}

%% 编号左对齐
\renewcommand\@biblabel[1]{%
  \makebox[\labelwidth][l]{[#1]}%
}

%% 数学定义、定理环境
\RequirePackage{amsthm}

\theoremstyle{plain}

%% `\theoremstyle{style}` 命令修改定理环境的样式，Latex 内置的样式（style参数）有三种：

%% plain（默认样式）：定理名称是正体，定理内容是斜体
%% definition：定理名称和定理内容都是正体
%% remark： 定理名称是斜体，定理内容是正体

\newtheorem{theorem}{\indent 定理}[chapter]
\newtheorem{lemma}[theorem]{\indent 引理}
\newtheorem{proposition}[theorem]{\indent 命题}
\newtheorem{corollary}[theorem]{\indent 推论}
\newtheorem{definition}{\indent 定义}[chapter]
\newtheorem{example}{\indent 例}[chapter]
\newtheorem{remark}{\indent 注}[chapter]
\newenvironment{solution}{\begin{proof}[\indent\bf 解]}{\end{proof}}
\renewcommand{\proofname}{\indent\bf 证明}

%% 去除数学定义编号后面默认的"."
\RequirePackage{xpatch}
\makeatletter
\xpatchcmd{\@thm}{\thm@headpunct{.}}{\thm@headpunct{}}{}{}

% 解决中英文混排时行内公式和长英文单词超出右边距的问题
\ifXeTeX
  \RequirePackage[protrusion=true, expansion=false, tracking=false]{microtype}
\else\ifLuaTeX
  \RequirePackage[protrusion=true, expansion=true, tracking=false]{microtype}
\fi\fi

% 断行参数调整
\tolerance=500                       
\hbadness=500                        
\emergencystretch=1.5em              
\hfuzz=0.3pt                         
\vfuzz=0.3pt                         

% 连字符和断词参数
\hyphenpenalty=100                   
\exhyphenpenalty=100                 
\doublehyphendemerits=10000          
\finalhyphendemerits=5000            
\adjdemerits=10000                   

% 中英文混排断行优化
\xeCJKsetup{
  CJKecglue = {\hskip 0.15em plus 0.1em minus 0.05em}, % 中英文间弹性空白
  CheckFullRight = true,             % 检查全角标点在行尾
}

\endinput