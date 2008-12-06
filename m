From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: New Force Feedback device support - GreenAsia 0x12
Date: Sat, 06 Dec 2008 13:08:25 +0100
Message-ID: <493A6B39.1070004@gmail.com>
References: <200811262333.45245.lukasz@lubojanski.info>	 <alpine.LNX.1.10.0811281514210.19853@jikos.suse.cz>	 <49303827.4050907@gmail.com>	 <200811282008.41601.lukasz@lubojanski.info>	 <alpine.LNX.1.10.0811292327470.19853@jikos.suse.cz>	 <92cd8c320812041235u6bf501d9ta473398bc1374aac@mail.gmail.com>	 <92cd8c320812041255i1a8bb4ces9468d2821ab7c620@mail.gmail.com>	 <493973BA.1010902@gmail.com> <92cd8c320812051249m39bcd8d6mb03e15e14398f01c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:62325 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754690AbYLFMId (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Dec 2008 07:08:33 -0500
Received: by nf-out-0910.google.com with SMTP id d3so199354nfc.21
        for <linux-input@vger.kernel.org>; Sat, 06 Dec 2008 04:08:32 -0800 (PST)
In-Reply-To: <92cd8c320812051249m39bcd8d6mb03e15e14398f01c@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?xYF1a2FzeiBMdWJvamHFhHNraQ==?= <lukasz@lubojanski.info>
Cc: Anssi Hannula <anssi.hannula@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On 12/05/2008 09:49 PM, =C5=81ukasz Luboja=C5=84ski wrote:
> Because the module supports only the FF now - I have changed module
> name to hid-gaff.

------=3D_Part_46985_7823613.1228510186768
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline

:(

+#define debug(format, arg...) pr_debug("hid-gaff: " format "\n" , ## a=
rg)

You don't need yet another pr_debug wrapper, use dev_dbg instead all ov=
er the code.

I would call the hid driver "hid-gaff" and won't add this to every prin=
t --
dev_* calls will do it on their own.

+static int ga_init(void)

mark as __init

+static void ga_exit(void)

mark as __exit

Otherwise looks good!
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
