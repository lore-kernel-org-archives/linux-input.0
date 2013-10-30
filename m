From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: wiimote: add pro-controller analog stick calibration
Date: Wed, 30 Oct 2013 08:54:47 +0100
Message-ID: <CANq1E4QDC4JW0=WFxnoEHgQy8jqaaKQrHpfHhMJQCyGyCuS_+A@mail.gmail.com>
References: <1382978960-849-1-git-send-email-dh.herrmann@gmail.com>
	<7969D126-74F7-4B91-9B5C-213AC76B3A66@rbrune.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:39409 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078Ab3J3Hys convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Oct 2013 03:54:48 -0400
Received: by mail-ie0-f179.google.com with SMTP id aq17so1621449iec.38
        for <linux-input@vger.kernel.org>; Wed, 30 Oct 2013 00:54:47 -0700 (PDT)
In-Reply-To: <7969D126-74F7-4B91-9B5C-213AC76B3A66@rbrune.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafael Brune <mail@rbrune.de>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi Rafael

On Wed, Oct 30, 2013 at 12:28 AM, Rafael Brune <mail@rbrune.de> wrote:
>
> On Oct 28, 2013, at 5:49 PM, David Herrmann <dh.herrmann@gmail.com> w=
rote:
>
>> The analog sticks of the pro-controller might report slightly off va=
lues.
>> To guarantee a uniform setup, we now calibrate analog-stick values d=
uring
>> pro-controller setup.
>>
>> Unfortunately, the pro-controller fails during normal EEPROM reads a=
nd I
>> couldn't figure out whether there are any calibration values stored =
on the
>> device. Therefore, we now use the first values reported by the devic=
e (iff
>> they are not _way_ off, which would indicate movement) to initialize=
 the
>> calibration values. To allow users to change this calibration data, =
we
>> provide a pro_calib sysfs attribute.
>>
>> We also change the "flat" values so user-space correctly smoothes ou=
r
>> data. It makes slightly off zero-positions less visible while still
>> guaranteeing highly precise movement reports. Note that the pro cont=
roller
>> reports zero-positions in a quite huge range (at least: -100 to +100=
).
>>
>> Reported-by: Rafael Brune <mail@rbrune.de>
>> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>
> Tested-by: Rafael Brune <mail@rbrune.de>
>
>> ---
>> Hi Rafael
>>
>> Could you give this a try? It works for me quite well.
>>
>> Thanks
>> David
>
> Hi David,
>
> also for me it works very well. As much as I don=92t like the =91init=
ialize by first
> observed values=92 approach, with the capability to change the calibr=
ation
> values from user-space it=92s a simple and good solution.
> Also I like the changes of the =91flat=92 values.
> We should keep our eyes open if other pro- or third-party controllers
> exceed the +/- 0x400 range of values more than our ones. But I think
> Nintendo does the calibration very similar and therefore that should =
not
> happen.
> Great work!

Thanks for testing! I am no big fan of this approach either. However,
it has the advantage that we can adjust the internal handling at any
time without affecting the outside. Problem with the min/max approach
is that it returns garbage until the first real *far* analog-movement.
I was thinking of a more advanced state-machine, but could not come up
with a good approach (neither do I have motivation and time to do some
more thorough research). I am willing to implement any extensions if
some-one has good ideas. But I'd like to see it added to "xwiishow"
first, so I can verify it works well. If it does, we can move it into
the hid-wiimote driver in the kernel.
=46urthermore, in case anyone finds out the EEPROM calib-storage, we ca=
n
easily adjust the kernel driver to read it from there.

@Jiri: I marked the sysfs-docs as 3.13. If it doesn't make it into the
next merge-window, I can resend it marked as 3.14.

Thanks for the report and testing!
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
