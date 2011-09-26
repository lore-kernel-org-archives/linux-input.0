From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH] Touchscreen driver for FT5x06 based EDT displays
Date: Mon, 26 Sep 2011 18:14:28 +0200
Message-ID: <4E80A4E4.9090501@kernelconcepts.de>
References: <1317053189-29831-1-git-send-email-simon.budig@kernelconcepts.de> <1317053189-29831-2-git-send-email-simon.budig@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:60842 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab1IZQua (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Sep 2011 12:50:30 -0400
Received: from [192.168.2.112]
	by mail.kernelconcepts.de with esmtpa (Exim 4.72)
	(envelope-from <simon.budig@kernelconcepts.de>)
	id 1R8E7n-0004zz-5r
	for linux-input@vger.kernel.org; Mon, 26 Sep 2011 18:33:47 +0200
In-Reply-To: <1317053189-29831-2-git-send-email-simon.budig@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all.

On 09/26/2011 06:06 PM, simon.budig@kernelconcepts.de wrote:
> From: Simon Budig <simon@budig.de>

Gah, managed to mess up with git send-email again. Sorry for that.

This is the message that was supposed to go along with the patch:

Hi all.

This is a driver for the EDT ft5x06 based capacitive touchscreens.

The driver supports up to 5 touch points, the "gain", "threshold" and
"offset" parameters can be configured via some files in the sysfs.

It also is possible to acquire some raw data from the sensor by putting
the sensor in a factory mode ("mode" file in sysfs) and then reading the
"raw" file, which contains the raw touch data. In factory mode the
reporting of regular events will stop.

I hope this can get integrated upstream, I appreciate any hints and
suggestions regarding the code.

Thanks,
        Simon Budig

- -- 
       Simon Budig                        kernel concepts GbR
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6ApOQACgkQO2O/RXesiHCXtgCeJ6DMV2mRJDKcJ7jbhttsvfCb
BSkAn0gNXBg7t2JYfxXoeAa8gkxRvwrr
=T2A2
-----END PGP SIGNATURE-----
