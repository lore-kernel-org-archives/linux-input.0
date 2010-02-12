From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH 1/4] HID: hid-ntrig add multi input quirk and clean up
Date: Thu, 11 Feb 2010 20:03:52 -0500
Message-ID: <4B74A8F8.3010701@seas.upenn.edu>
References: <1265933946-8318-1-git-send-email-rafi@seas.upenn.edu> <20100212003604.GA6394@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:56501 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757624Ab0BLBEA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Feb 2010 20:04:00 -0500
In-Reply-To: <20100212003604.GA6394@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chatty@enac.fr

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>  	nd = kmalloc(sizeof(struct ntrig_data), GFP_KERNEL);
>>  	if (!nd) {
>> @@ -255,14 +271,36 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>  	if (!ret)
>>  		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>>  
>> -	if (ret)
>> +	if (ret) {
>>  		kfree (nd);
> 
> What about hid_hw_stop()? Overall I'd rather see the standard error
> unwinding path with gotos.

Cleaning up the probe function.  But it looks like the last caught error is from start, so is it fair to leave out stop?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkt0qPUACgkQwuRiAT9o60+REACg6T73GpC3jz5dkAW+CFsAPLsz
w4sAn3ttnpvH85bECwYxe8WPhJ77Zs2z
=xRv3
-----END PGP SIGNATURE-----
