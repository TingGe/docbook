XMLmind免费的XML编辑器
================

[下载][1]

[1]: <http://www.xmlmind.com/xmleditor/download.shtml>

使用
--

[XMLmind XML编辑器——官网首页教程][2]

[2]: <http://www.xmlmind.com/xmleditor/_primer/xxe_primer.swf>

[XMLmind XML编辑器——在线帮助][3]

[3]: <http://www.xmlmind.com/xmleditor/_distrib/doc/help/wh/index.html>

参考
--

[在路上][4]

[4]: <http://www.crifan.com/category/work_and_job/docbook/>



ZoeeyDoc DocBook文档构建工具
======================

ZoeeyDoc 是一个docbook文档构建工具，支持 single-html、html、chm、pdf 等格式导出。对中文支持良好。

优点
--

-   纯文本格式：基于xml，纯文本格式方便版本控制。章节可分为独立的文件和目录进行编辑。

-   多格式发布：经过一次书写便可以输出html、chm、pdf等众多格式，极大的方便了阅读。

-   排版格式：排版格式精良。DocBook与专业排版工具TeX实力相当。常用来制作出版发行物、专业论文、软件手册等。

-   格式规范：纯xml格式，有众多编辑工具，格式规范便于自动检验。

-   中文支持：良好的中文支持自动引用系统字体生成pdf所需的字体描述文件。

-   自动化支持：采用纯命令行形式，可方便的加入到各类自动构建工具中。

-   人工服务：本地化，中文在线问题疑难解答。

-   其他：生成single-html、html等格式会自动打包为zip文件。且zip、pdf、chm等文件会自动生成checksum 校验文件。

下载
--

http://code.google.com/p/zoeeydoc/

手册
--

+--------+----------+----------------+----------------+

| 格式     | 地址       | checksum       | 备注             |

+--------+----------+----------------+----------------+

| chm    | [chm][5] | [checksum][9]  | 无法查看：文件属性，解除锁定 |

+--------+----------+----------------+----------------+

| html   | [zip][6] | [checksum][10]  |                |

+--------+----------+----------------+----------------+

| pdf    | [pdf][7] | [checksum][11] |                |

+--------+----------+----------------+----------------+

| single | [zip][8] | [checksum][12] |                |

+--------+----------+----------------+----------------+

[5]: <http://zoeeydoc.googlecode.com/hg/build/zoeeydoc.chm>

[6]: <http://zoeeydoc.googlecode.com/hg/build/zoeeydoc.zip>

[7]: <http://zoeeydoc.googlecode.com/hg/build/zoeeydoc.pdf>

[8]: <http://zoeeydoc.googlecode.com/hg/build/zoeeydoc-single.zip>

[9]: <http://zoeeydoc.googlecode.com/hg/build/zoeeydoc.chm.checksum>

[10]: <http://zoeeydoc.googlecode.com/hg/build/zoeeydoc.zip.checksum>

[11]: <http://zoeeydoc.googlecode.com/hg/build/zoeeydoc.pdf.checksum>

[12]: <http://zoeeydoc.googlecode.com/hg/build/zoeeydoc-single.zip.checksum>

示例项目
----

【含文档源码、各格式下载】 http://code.google.com/p/cnphpdocs/

【含文档源码】             http://code.google.com/p/yafphp/

【含文档源码、各格式下载】 http://code.google.com/p/zoeeyphp/

使用说明
----

======================== ZoeeyDoc help: ======================== 
-h/--help :  打印此文档。

-c/--clean :  清理缓存文件。

-t/--type :  转换目标类型（chm,html,single/singlehtml），默认为 html。

-b/--book :  文档目录。 文件配置文件为文件路径+"/config.kv"

获取帮助 java -jar ZoeeyDoc.jar -h

生成 html java -jar ZoeeyDoc.jar -b docs/books/zoeeydoc -t html

生成 single html java -jar ZoeeyDoc.jar -b docs/books/zoeeydoc -t single

生成 chm （需要指定hhc目录） java -jar ZoeeyDoc.jar -b docs/books/zoeeydoc -t chm

参考资料
----

[DocBook][13]  
  
[DocBook XSL: The Complete Guide][14]  
  
[ZoeeyDoc 使用技巧][15]

[13]: <http://www.docbook.org/>

[14]: <http://www.sagehill.net/docbookxsl/index.html>

[15]: <http://blog.zoeey.org/2011/03/12/zoeeydoc-docbook/>

其它
--

java运行所需要的Jre：[Jre][16]

[16]: <http://www.java.com/en/download/index.jsp>

chm生成需要的hhc:[Microsoft HTML Help Downloads][17]

[17]: <http://msdn.microsoft.com/en-us/library/ms669985%28v=vs.85%29.aspx>


ZoeeyDoc作者
----------

email: system128@gmail.com

qq: 5943590
