From: yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: NEW SUN4i KEYPAD DRIVER
Date: Wed, 16 Sep 2015 00:05:53 +1000
Message-ID: <1442325957-10102-1-git-send-email-yassinjaffer@gmail.com>
Reply-To: yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDCKXM7WZYLRBYWL4CXQKGQE3ASQQUI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

This series adds support for the sun4i keypad Controller
I've tested the driver in a A20 custom board (4x4) only
Allwinner keypad controller does not seem to handle more
than two key press

Please test and report bugs. Thank you in advance

[PATCH 1/4] ARM:dts:sun7i: Add keypad clk node
[PATCH 2/4] ARM: dts: sun7i: Add keypad node to Allwinner A20 SoC
[PATCH 3/4] input: Add new sun4i-keypad driver
[PATCH 4/4] devicetree: bindings:Allwinner sun4i keypad
