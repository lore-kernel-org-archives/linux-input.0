From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH 1/4] HID: hid-ntrig add multi input quirk and clean up
Date: Thu, 11 Feb 2010 19:45:52 -0500
Message-ID: <4B74A4C0.1030402@seas.upenn.edu>
References: <1265933946-8318-1-git-send-email-rafi@seas.upenn.edu> <20100212003604.GA6394@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:47015 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab0BLAp6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Feb 2010 19:45:58 -0500
In-Reply-To: <20100212003604.GA6394@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chatty@enac.fr

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/11/10 19:36, Dmitry Torokhov wrote:
> Hi Rafi,
> 
> On Thu, Feb 11, 2010 at 07:19:03PM -0500, Rafi Rubin wrote:
>> Added a quirk to enable distinct input devices.  The digitizer utilizes
>> three inputs to represent pen, multitouch and a normal touch screen.
>>
>> With the Pen partitioned, it behaves well and does not need special
>> handling.
>>
>> Also, I set names to the input devices to clarify the functions of the
>> various inputs.
>>
> 
> Overall looks much nicer (goes for all 4 patches) and reader should be
> able to see what is going on much easier now.
> 
> Couple of formatting nits still (I am pretty sure scripts/checkpatch.pl
> warns about these as well):

Fair enough.  I ran it through scripts/Lindent for the 4th patch.  I guess
that's not as thorough and I should have checked earlier.

>> -	if (ret)
>> +	if (ret) {
>>  		kfree (nd);
> 
> What about hid_hw_stop()? Overall I'd rather see the standard error
> unwinding path with gotos.

Ok.

>> +			if(hidinput->report->field[0]->physical) {
>> +				input->name = "N-Trig Touchscreen";
>> +			} else {
>> +				input->name = "N-Trig MultiTouch";
>> +			}
> 
> No need for curly braces for single-line statements. Maybe compress to
> ?: statement?

That's an artifact of staging the changes.  Oddly enough my original version was just ?:

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkt0pL8ACgkQwuRiAT9o6098awCeLFRkVATyURHEBszR63dvzfWK
B7gAoNevD3DmWK3qgCEGIGgqKGY3f8aU
=2z1B
-----END PGP SIGNATURE-----
