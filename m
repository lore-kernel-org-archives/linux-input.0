From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH v7] Touchscreen driver for FT5x06 based EDT displays
Date: Mon, 02 Jul 2012 11:55:34 +0200
Message-ID: <4FF17016.40505@kernelconcepts.de>
References: <1340408898-491-1-git-send-email-simon.budig@kernelconcepts.de> <1341175006-24579-1-git-send-email-simon.budig@kernelconcepts.de> <1341175006-24579-2-git-send-email-simon.budig@kernelconcepts.de> <20120702093107.GA1286@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:37458 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482Ab2GBJzo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Jul 2012 05:55:44 -0400
In-Reply-To: <20120702093107.GA1286@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, olivier@sobrie.be, agust@denx.de, yanok@emcraft.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Henrik.

On 07/02/2012 11:31 AM, Henrik Rydberg wrote:
> Thank you for the thorough set of changes. Some minor comments 
> below.

Will try to address the new ones soonish  :)

>> +	wrbuf[0] = 0xf5; +	wrbuf[1] = 0x0e; +	for (pos = *off; pos < 
>> endpos; pos += colbytes) { +		wrbuf[2] = pos / colbytes;  /* 
>> column index */ +		error = 
>> edt_ft5x06_ts_readwrite(tsdata->client, +						sizeof(wrbuf), 
>> wrbuf, +						colbytes, rdbuf); +		if (error) +			goto out; + + 
>> start_off = pos % colbytes; +		error = copy_to_user(buf + pos - 
>> *off, rdbuf + start_off, +				     MIN(colbytes - start_off, 
>> endpos - pos));
> 
> Quite a few variables in play here... it looks correct, but a) 
> breaking out parts of this function would not hurt, and b) I bet 
> the column-by column copy-to-user algorithm could be slightly less
>  involved.

Hmm, I originally had it implemented as requiring offset == 0 as well
as buffer size big enough. That way it was as easy as the previous
sysfile implementation. I was unsure if this is acceptable though.

Not sure if dealing with the four possible cases independently would
improve things. I can only get the data in column-sized chunks and if
the buffer to fill is not properly aligned to these it will get a bit
messy.

I could allocate a temporary buffer for the whole raw frame, fill it
once (e.g. when offset == 0 or even on open()) and then just copy it
into the output buffer.

Maybe this is a more viable approach.

Bye,
        Simon

- -- 
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/xcBYACgkQO2O/RXesiHCGhwCeICHFEGfBP0ejWHSDfsFbHRKm
WoEAn3LFFapVRYKokhxtbm56SLxmSIep
=vd6q
-----END PGP SIGNATURE-----
