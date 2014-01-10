From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Re: [PATCH] Introduce Naming Convention in Input Subsystem
Date: Fri, 10 Jan 2014 08:31:32 -0800
Message-ID: <20140110163131.GA10889@core.coreip.homeip.net>
References: <FB.45.09100.85A10D25@epcpsbgx2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:64880 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbaAJQbh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jan 2014 11:31:37 -0500
Received: by mail-pd0-f178.google.com with SMTP id y10so4756642pdj.23
        for <linux-input@vger.kernel.org>; Fri, 10 Jan 2014 08:31:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <FB.45.09100.85A10D25@epcpsbgx2.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <a.mathur@samsung.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "cpgs ." <cpgs@samsung.com>, Anurag Aggarwal <a.anurag@samsung.com>, Naveen Kumar <naveen.sel@samsung.com>, "aniroop.mathur@gmail.com" <aniroop.mathur@gmail.com>, VIKAS KALA <vikas.kala@samsung.com>, Poorva Srivastava <poorva.s@samsung.com>

Hi Aniroop,

On Fri, Jan 10, 2014 at 04:05:44PM +0000, Aniroop Mathur wrote:
> <HTML><HEAD><TITLE>Samsung Enterprise Portal mySingle</TITLE>
> <META content="text/html; charset=windows-1252" http-equiv=Content-Type>
> <STYLE id=mysingle_style type=text/css>P {

Please no HTML mail as mainling lists drop it.

Thanks.

> 	MARGIN-TOP: 5px; FONT-FAMILY: Arial, arial; MARGIN-BOTTOM: 5px; FONT-SIZE: 9pt
> }
> TD {
> 	MARGIN-TOP: 5px; FONT-FAMILY: Arial, arial; MARGIN-BOTTOM: 5px; FONT-SIZE: 9pt
> }
> LI {
> 	MARGIN-TOP: 5px; FONT-FAMILY: Arial, arial; MARGIN-BOTTOM: 5px; FONT-SIZE: 9pt
> }
> BODY {
> 	LINE-HEIGHT: 1.4; MARGIN: 10px; FONT-FAMILY: Arial, arial; FONT-SIZE: 9pt
> }
> </STYLE>
> 
> <META name=GENERATOR content=ActiveSquare></HEAD>
> <BODY>
> <P>Hello Mr. Torokhov,</P>
> <P>Greetings!</P>
> <P><BR>On Thu, Jan 09, 2014 at 10:27:56AM +0530, Aniroop Mathur wrote:<BR>&gt; This patch allows user(driver) to set sysfs node name of input<BR>&gt; devices.&nbsp;&nbsp;To set sysfs node name, user(driver) just needs to set<BR>&gt; node_name_unique variable.&nbsp;&nbsp;If node_name_unique is not set, default<BR>&gt; name is given(as before).&nbsp;&nbsp;So, this patch is completely<BR>&gt; backward-compatible.<BR>&gt; <BR>&gt; Sysfs Input node name format is: input_<NAME><BR>&gt; Sysfs Event node name format is: event_<NAME><BR>&gt;<BR>&gt; This "name" is given by user and automatically, prefix(input and<BR>&gt; event) is added by input core.<BR>&gt; <BR>&gt; This name must be unique among all input devices and driver(user) has<BR>&gt; the responsibility to ensure it.&nbsp;&nbsp;If same 
 name is used again for other<BR>&gt; input device, registration of that input device will fail because two<BR>&gt; input devices cannot have same name.<BR>&gt; <BR>&gt; Advantages of this patch are:<BR>&gt; <BR>&gt; 1. Reduces Booting Time of HAL/Upper-Layer because now HAL or<BR>&gt; Upper-Layer do not need to search input/event number corresponding to<BR>&gt; each input device in /dev/input/...&nbsp;&nbsp;This searching in /dev/input/ was<BR>&gt; taking too much time.&nbsp;&nbsp;(Especially in mobile devices, where there are<BR>&gt; many input devices (many sensors, touchscreen, etc), it reduces a lot<BR>&gt; of booting time)<BR><BR>I am sorry, how much time does it take to scan a directory of what, 20<BR>devices? If it such a factor have udev create nodes that are easier for<BR>you to
  locate, similarly how we already create nodes by-id and by-path.<BR>For example you can encode major:minor in device name.</P>
> <P>&nbsp;</P>
> <P><STRONG><SPAN style="FONT-SIZE: 11pt">Re: (Aniroop Mathur)</SPAN></STRONG></P>
> <P>Its correct that we can set name of a device node using udev. <BR>Yes, this will change the name of device node(/dev/...) but not sysfs node.(/sys/class/input/...)<BR><STRONG>So now, the problem area will shift from dev path to sysfs path, <BR></STRONG>because now we dont know which sysfs node to refer for a particular input device<BR>and hence HAL/Upper-Layer will need to search in /sys/class/input/... instead of /dev/... directory.</P>
> <P>&nbsp;</P>
> <P>Moreover, as i know, udev is mainly for hot-pluggable devices, but my problem is for platform devices,<BR>which are already present on the board during boot up. (Like in Embedded devices)</P>
> <P>&nbsp;</P>
> <P>To avoid confusion and make the problem more clear, <BR>I would like to explain the problem and my suggestion by taking an example:</P>
> <P>&nbsp;</P>
> <P>Suppose in a mobile device, there are 10 embedded input devices as below:<BR><STRONG>Proximity&nbsp;---&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/dev/input0&nbsp; --- /sys/class/input/input0&nbsp;--- /sys/class/input/event0<BR>Magnetometer&nbsp;---&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/dev/input1&nbsp;&nbsp; --- /sys/class/input/input1&nbsp;--- /sys/class/input/event1<BR>Accelerometer&nbsp;---&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/dev/input2&nbsp; --- /sys/class/input/input2&nbsp;--- /sys/class/input/event2<BR>Touchscreen&nbsp;---&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/dev/input3&nbsp; --- /sys/class/input/input3&nbsp;--- /sys/class/input/event3 </STRONG></P>
> <P><STRONG>... 6 more like this<BR></STRONG>(All these are created during boot up time)</P>
> <P>&nbsp;</P>
> <P>Kernel has created all these nodes, so that HAL/UpperLayer can read or write values from it.<BR>HAL/Upper-Layer needs to do main tasks like:<BR>1. Read raw data - does through /dev/input&lt;num&gt;<BR>2. Enable device - does through sys/class/input&lt;num&gt;/enable<BR>3. Set delay - does through sys/class/input&lt;num&gt;/delay<BR>and many more...</P>
> <P>&nbsp;</P>
> <P>Now, Lets suppose we need to do these tasks for Accelerometer.</P>
> <P>If dev node name is set, HAL can directly read value from it (no search required)<BR><STRONG>But for enabling the accelerometer device or set the delay of a hardware chip, <BR>there is no direct way, HAL can know which input node to refer for accelerometer<BR>because the input number is created dynamically as per device probe order,<BR>so this input number can be anything (0,1,2,3...)<BR></STRONG>So HAL will need to search every input node and read its name attribute<BR>and keep on searching until a match is found between the "attribute name" and "name passed as parameter". <BR>Like for accelerometer, this searching needs to be done for all other input devices.<BR>All of this part is done during booting and this takes a lot for time from booting perspective.</P>
> <P>&nbsp;</P>
> <P><STRONG>As I measured, if there are ten devices, it is taking 1 second to do all this searching. (for all devices)<BR>So for 20 devices, i guess, it could take upto 2 seconds.</STRONG></P>
> <P><STRONG></STRONG>&nbsp;</P>
> <P><STRONG>With naming convention, there is no need of search neither for dev path nor for sysfs path<BR>because HAL directly know which node to refer for which input device<BR>and hence this 1 second is reduced to 10ms or even less, therefore saving 990ms.<BR>I believe, this is a very good time saving. (from device booting perspective)</STRONG></P>
> <P>&nbsp;</P>
> <P>(Is there any direct way, without scanning all nodes for every input device ?)</P>
> <P><BR>&gt; <BR>&gt; 2. Improves Readabilty of input and event sysfs node paths because<BR>&gt; names are used instead of numbers.<BR><BR>I do not see why it is that important. If one wants overview<BR>/proc/bus/input/devices gives nice picture.</P>
> <P>&nbsp;</P>
> <P><STRONG><SPAN style="FONT-SIZE: 11pt">Re: (Aniroop Mathur)</SPAN></STRONG></P>
> <P>Its correct, we can get an overview from /proc/bus/input/devices.<BR>And therefore using this, we can know input node number for every input device.<BR>But there are many input devices and input numbers are not fixed, <BR>so its quite difficult to memorize input number for all input devices.<BR><STRONG>Therefore, if a user needs to open some input node from sysfs path,<BR>he needs to check /proc/bus/input/devices before opening because <BR>he does not know the input number. Moreover, this applies for all other<BR>input devices and hence a user need to check this every time.</STRONG><STRONG><BR></P></STRONG>
> <P>It improves readabilty&nbsp;as below</P>
> <P>&nbsp;</P>
> <TABLE style="BACKGROUND-COLOR: #ffffff; WIDTH: 375px" border=1 cellSpacing=0 width=375>
> <TBODY>
> <TR>
> <TD height=26 width=151>
> <P>&nbsp;Before</P></TD>
> <TD height=26 width=214>
> <P>&nbsp;After Patch</P></TD></TR>
> <TR>
> <TD height=26 width=151>
> <P><STRONG>dev node paths:</STRONG></P>
> <P><STRONG></STRONG>&nbsp;</P>
> <P>/dev/input0</P>
> <P>/dev/input1</P>
> <P>... many more&nbsp;</P></TD>
> <TD height=26 width=214>
> <P><STRONG>dev node paths:</STRONG></P>
> <P><STRONG></STRONG>&nbsp;</P>
> <P>/dev/input_proximity</P>
> <P>/dev/input_accelerometer</P>
> <P>... many more&nbsp;</P></TD></TR>
> <TR>
> <TD height=26 width=151>
> <P><STRONG>sysfs node paths:</STRONG></P>
> <P><STRONG></STRONG>&nbsp;</P>
> <P>/sys/class/input/input0</P>
> <P>/sys/class/input/input1&nbsp;</P>
> <P>... many more</P>
> <P>&nbsp;</P>
> <P>/sys/class/input/event0</P>
> <P>/sys/class/input/event1</P>
> <P>...many more</P></TD>
> <TD height=26 width=214>
> <P><STRONG>sysfs node paths:</STRONG></P>
> <P><STRONG></STRONG>&nbsp;</P>
> <P>/sys/class/input/input_proximity</P>
> <P>/sys/class/input/input_accelerometer</P>
> <P>... many more</P>
> <P>&nbsp;</P>
> <P>/sys/class/input/event_proximity</P>
> <P>/sys/class/input/event_accelerometer</P>
> <P>... many more</P></TD></TR></TBODY></TABLE>
> <P>&nbsp;</P>
> <P><STRONG>So, just by looking, user can directly open or refer any input node.<BR>(no need to refer any other path)</STRONG><STRONG></P>
> <P><BR></STRONG>&gt; <BR>&gt; 3. Removes Input Devices Dependency. If one input device probe fails,<BR>&gt; other input devices still work.&nbsp;&nbsp;Before this patch, if one input<BR>&gt; device probe fails before input_register_device, then input number of<BR>&gt; other input devices changes and due to this permission settings are<BR>&gt; disturbed and hence HAL or upper layer cannot open the required sysfs<BR>&gt; node because permission denied error comes.<BR><BR>I have only one suggestion here: fix your userspace so that does not<BR>depend on device initialization ordering.<BR></P>
> <P><STRONG><SPAN style="FONT-SIZE: 11pt">Re: (Aniroop Mathur)</SPAN></STRONG></P>
> <P><STRONG>We cannot fix userspace because these input/event/dev number are decided/allocated in kernel<BR>as per device initialization ordering during boot up. (userspace has no role in it)<BR></STRONG>So, userspace is not aware, which exact input number corresponds to which input device <BR>so it ends up searching/scanning every input node untill a match is found.</P>
> <P>So, there is input device dependency which needs to be removed.</P>
> <P>&nbsp;</P>
> <P><BR>IOW I am totally unconvinced that this facility is needed.</P>
> <P><STRONG><SPAN style="FONT-SIZE: 11pt">Re: (Aniroop Mathur)</SPAN></STRONG></P>
> <P>I hope my problem and suggestion is more clear and convincing now.</P>
> <P>&nbsp;</P>
> <P>&nbsp;</P>
> <P><STRONG>For reference, copying Patch again:</STRONG></P>
> <P>---<BR>drivers/input/evdev.c |&nbsp;&nbsp; 11 ++++++++++-<BR>drivers/input/input.c |&nbsp;&nbsp; 12 +++++++++++-<BR>include/linux/input.h |&nbsp;&nbsp;&nbsp; 4 ++++<BR>3 files changed, 25 insertions(+), 2 deletions(-)<BR><BR>diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c<BR>index b6ded17..b6a5848 100644<BR>--- a/drivers/input/evdev.c<BR>+++ b/drivers/input/evdev.c<BR>@@ -1131,7 +1131,16 @@ static int evdev_connect(struct input_handler *handler, struct input_dev *dev,<BR>/* Normalize device number if it falls into legacy range */<BR>if (dev_no &lt; EVDEV_MINOR_BASE + EVDEV_MINORS)<BR>dev_no -= EVDEV_MINOR_BASE;<BR>- dev_set_name(&amp;evdev-&gt;dev, "event%d", dev_no);<BR>+<BR>+ /*<BR>+ * As per user choice (driver),<BR>+ * name of sysfs node is set, as mentioned in node_nam
 e_unique variable.<BR>+ * If node_name_unique is not set, default name is given.<BR>+ */<BR>+ if (dev-&gt;node_name_unique)<BR>+ dev_set_name(&amp;evdev-&gt;dev, "event_%s", dev-&gt;node_name_unique);<BR>+ else<BR>+ dev_set_name(&amp;evdev-&gt;dev, "event%d", dev_no);<BR><BR>evdev-&gt;handle.dev = input_get_device(dev);<BR>evdev-&gt;handle.name = dev_name(&amp;evdev-&gt;dev);<BR>diff --git a/drivers/input/input.c b/drivers/input/input.c<BR>index c044699..c8126b3 100644<BR>--- a/drivers/input/input.c<BR>+++ b/drivers/input/input.c<BR>@@ -2073,7 +2073,17 @@ int input_register_device(struct input_dev *dev)<BR>if (!dev-&gt;setkeycode)<BR>dev-&gt;setkeycode = input_default_setkeycode;<BR><BR>- dev_set_name(&amp;dev-&gt;dev, "input%ld",<BR>+ /*<BR>+ * As per user choice (driver),<BR>+ * name o
 f sysfs node is set, as mentioned in node_name_unique variable.<BR>+ * If node_name_unique is not set, default name is given.<BR>+ */<BR>+ if (dev-&gt;node_name_unique) {<BR>+ atomic_inc_return(&amp;input_no);<BR>+ dev_set_name(&amp;dev-&gt;dev, "input_%s",<BR>+ &nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;node_name_unique);<BR>+ } else<BR>+ dev_set_name(&amp;dev-&gt;dev, "input%ld",<BR>&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long) atomic_inc_return(&amp;input_no) - 1);<BR><BR>error = device_add(&amp;dev-&gt;dev);<BR>diff --git a/include/linux/input.h b/include/linux/input.h<BR>index 82ce323..fe44643 100644<BR>--- a/include/linux/input.h<BR>+++ b/include/linux/input.h<BR>@@ -43,6 +43,9 @@ struct input_value {<BR>&nbsp; * @uniq: unique identification code for the device (if device has it)<BR>&nbsp; * @id:
  id of the device (struct input_id)<BR>&nbsp; * @propbit: bitmap of device properties and quirks<BR>+ * @node_name_unique: name of input and event sysfs device node (char *).<BR>+ * This name must be unique among all input devices and driver(user)<BR>+ * has the responsibility to ensure it (if using).<BR>&nbsp; * @evbit: bitmap of types of events supported by the device (EV_KEY,<BR>&nbsp; * EV_REL, etc.)<BR>&nbsp; * @keybit: bitmap of keys/buttons this device has<BR>@@ -123,6 +126,7 @@ struct input_dev {<BR>const char *phys;<BR>const char *uniq;<BR>struct input_id id;<BR>+ char *node_name_unique;<BR><BR>unsigned long propbit[BITS_TO_LONGS(INPUT_PROP_CNT)];<BR><BR>-- <BR>1.7.0.4<BR><BR></P>
> <P>Thanks,</P>
> <P>Aniroop Mathur</P>
> <P>&nbsp;</P>
> <TABLE id=confidentialsignimg>
> <TBODY>
> <TR>
> <TD NAMO_LOCK>
> <P><IMG border=0 src="cid:QKNMBDIFBEI0@namo.co.kr" width=520></P></TD></TR></TBODY></TABLE></BODY></HTML><img src='http://ext.samsung.net/mailcheck/SeenTimeChecker?do=166e1c9f408a9352202b65e5c362a372ac21ff698029c65acf20909b63ed3e8c4e627947a285d7d76b91358bc02b4ef9c7b41e955949e5c8a728c55b39cc59eacf878f9a26ce15a0' border=0 width=0 height=0 style='display:none'>


-- 
Dmitry
