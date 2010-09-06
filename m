From: Sundar R IYER <sundar.iyer@stericsson.com>
Subject: RE: [PATCH v3 1/1] input: add support for Nomadik SKE keypad
 controller
Date: Mon, 6 Sep 2010 17:43:41 +0200
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B181C7DC6A5@EXDCVYMBSTM006.EQ1STM.local>
References: <1283777284-24811-1-git-send-email-sundar.iyer@stericsson.com>
 <0680EC522D0CC943BC586913CF3768C003C20185F8@dbde02.ent.ti.com>
 <33A307AF30D7BF4F811B1568FE7A9B181C7DC680@EXDCVYMBSTM006.EQ1STM.local>
 <0680EC522D0CC943BC586913CF3768C003C2018609@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:58698 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752746Ab0IFPn6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 6 Sep 2010 11:43:58 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003C2018609@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

Hi again,

>-----Original Message-----
>From: Datta, Shubhrajyoti [mailto:shubhrajyoti@ti.com]
>
>     if (keypad->board->exit)
>             keypad->board->exit();
>Is this you intended?

Oops. I wronged this one.
Anyways, I will wait for Dmitry's further comments before I spin a v4 of this.

Regards,
Sundar
