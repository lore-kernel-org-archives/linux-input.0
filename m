From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] HID: ntrig don't dereference unclaimed hidinput
Date: Tue, 08 Mar 2011 08:47:09 -0500
Message-ID: <4D76335D.3020305@seas.upenn.edu>
References: <1299550408-11457-1-git-send-email-rafi@seas.upenn.edu> <1299561869-15165-1-git-send-email-rafi@seas.upenn.edu> <alpine.LNX.2.00.1103081433320.19969@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fox.seas.upenn.edu ([158.130.68.12]:55940 "EHLO
	fox.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab1CHNrX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Mar 2011 08:47:23 -0500
In-Reply-To: <alpine.LNX.2.00.1103081433320.19969@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, rydberg@euromail.se, chatty@enac.fr, peter.hutterer@who-t.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/08/11 08:35, Jiri Kosina wrote:
> On Tue, 8 Mar 2011, Rafi Rubin wrote:
> 
>> Check before dereferencing field->hidinput to fix a reported invalid
>> deference bug.
>>
>> Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
>> ---
>> After additional debugging, I realized I'm seeing a variant of Peter's
>> bug.  On unloading and then reloading hid-ntrig I'm seeing calls during
>> initialization to ntrig_event where field->hidinput is NULL and the
>> claimed input flag is still set.  It seems to me this behavior shouldn't
>> happen and the check should be further up the stack.
> 
> Actually after thinking about it a little bit more, I don't think this 
> should be handled up the stack (i.e. in hid_process_event()) -- there 
> might be HID-bus drivers which would be interested in reports even if not 
> claimed by hid-input.

I was thinking of the case where a field is tagged as a claimed input, but isn't
initialized, at least not yet.  The problems Peter and I have been seeing may
actually be the result of a couple buggy firmwares.  Still a misbehaving device
should not crash the kernel.

I do agree that it makes sense to let the non-claimed-input events get to the
leaf drivers.  I may even have such a device in use at home (not really sure, I
took a temporary short cut and am using it with direct libusb calls from user
space).

>> Sorry about sending a such a trivial patch repeatedly :/
>> ---
>>  drivers/hid/hid-ntrig.c |   15 ++++++++++++++-
>>  1 files changed, 14 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
>> index beb4034..a93e58c 100644
>> --- a/drivers/hid/hid-ntrig.c
>> +++ b/drivers/hid/hid-ntrig.c
>> @@ -539,8 +539,19 @@ static int ntrig_input_mapped(struct hid_device *hdev, struct hid_input *hi,
>>  static int ntrig_event (struct hid_device *hid, struct hid_field *field,
>>  			struct hid_usage *usage, __s32 value)
>>  {
>> -	struct input_dev *input = field->hidinput->input;
>>  	struct ntrig_data *nd = hid_get_drvdata(hid);
>> +	struct input_dev *input;
>> +
>> +	/* Skip processing if not a claimed input */
>> +	if (!(hid->claimed & HID_CLAIMED_INPUT))
>> +		goto not_claimed_input;
>> +
>> +	/* This function is being called before the structures are fully
>> +	 * initialized */
>> +	if(!(field->hidinput && field->hidinput->input))
>> +		return -EINVAL;
>> +
>> +	input = field->hidinput->input;
> 
> But audit of other drivers which rely on HID_CLAIMED_INPUT flag should be 
> done, yes.
> 
> Applied, thanks.
> 

Thanks,
Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJNdjNaAAoJEPILXytRLnK2LmEP/0vVRaewOsTUyaXdgIoGLcp6
haKcJC7zdcAdI162dFQrhXY98qw4fRvpZdewSJBrkGjj2hti5KcObwO8dYv5MakD
o5JrjyIOqJH8hWI/tYLvGrtrAQY/0PyZ0Cr/0yOoJ6EXkWk0Q7B7GCjyk5eEKToR
R2V48svETJi61sBsnGpsNotihItRNgv6yTp807R9WRDszvta49PpJ7HRZ8gSD94D
992J8Tn+cesHhf1g0zztGRxEnGCDMclLaHF7l/94jwQGi63FkX1Eknx0lmWvy1Uq
qFEroGWFYY2aM3vjoeaImIMO9z1kFMMta2pGbRdGUOMa7NhPsy4rLjFT/VSI+to3
/v0vCzzac5aWqcqNkylSjgLzXzvcRs9xQGTDr/i0C64SjE7pTJ/hiHVHKY9aqfga
1RAUvbv9Vp31X9KkIC1akBzFjTofYzk0dKCpqR3C1SYcj/BTlglhLOm9sH3g3Z+n
Tt+VZJAE3RKMXNui2io+vifnRGlnvcqH3Sz/7Qoxc9Nj5gn+uVsh1elcWrRYkWc8
TyyP30CT+Rr+hYh/VQZBTLJ13OR6nF2ZR/3n701baQHX54jkwoWgzTZGOP5KxYWe
BT0CUP24qan9xGsKbw/AC+35cYWjGeXS9A6JjSwdAd9BwB5M09BLymznXyEMVuKt
C3yO6Q2hA81n0LHu9mS8
=4Xch
-----END PGP SIGNATURE-----
