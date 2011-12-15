From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH v2] Touchscreen driver for FT5x06 based EDT displays
Date: Thu, 15 Dec 2011 12:00:03 +0100
Message-ID: <4EE9D333.8050107@kernelconcepts.de>
References: <1317311577-29742-1-git-send-email-simon.budig@kernelconcepts.de>	<1317311577-29742-2-git-send-email-simon.budig@kernelconcepts.de> <20111202145146.33d5b8be@wker>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:44637 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728Ab1LOLAG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Dec 2011 06:00:06 -0500
In-Reply-To: <20111202145146.33d5b8be@wker>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ilya Yanok <yanok@emcraft.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Anatolij.

On 12/02/2011 02:51 PM, Anatolij Gustschin wrote:
> there is a number of issues with this patch. Please check it
> using 'scripts/checkpatch.pl' and fix them before posting next
> patch version. Thanks! Please see a comment below.

Ok, There are a lot of warnings/errors regarding my use of spaces for
alignment of multi-line function calls.

(i.e. use tabs for the logical indentation level plus spaces to align
e.g. function arguments behind the opening parenthesis)

<tab><tab>function (argument1,
<tab><tab>          argument2);

This has the advantage of not breaking alignment when changing tab
width. Is this something acceptable in the kernel? It seems CodingStyle
is open to interpretation there, not sure if the conding style is open
for discussion though...  :)

Or should I just globally replace 8 subsequent spaces with a tab?

> passing platform data for specifying reset_pin should be optional,
> I think. There are hardware configurations without wired gpio for
> /RST controlling, /RST is controlled by HW-circuitry. The driver
> should be usable with such configurations, too. Can you please
> change the driver so that controlling reset pin becomes optional?

Will do.

Thanks,
        Simon
- -- 
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7p0zMACgkQO2O/RXesiHBbqQCglB7P11riuVoM1pKQ7CLRusmP
uMYAnRWclP+LLcKWmwvndvm38V1BoK1T
=wmrp
-----END PGP SIGNATURE-----
