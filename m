From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: Handling Controllers with Acc/Gyro/Mag via HID system
Date: Mon, 08 Jun 2015 18:43:23 -0400
Message-ID: <55761A8B.2080908@gmail.com>
References: <195dff9bd065db7e618280cb7c6eb5a9.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36662 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932693AbbFHWn2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Jun 2015 18:43:28 -0400
Received: by igbpi8 with SMTP id pi8so73289836igb.1
        for <linux-input@vger.kernel.org>; Mon, 08 Jun 2015 15:43:28 -0700 (PDT)
In-Reply-To: <195dff9bd065db7e618280cb7c6eb5a9.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org, linux-input@vger.kernel.org
Cc: Frank Praznik <frank.praznik@oh.rr.com>

On 6/8/2015 11:41, simon@mungewell.org wrote:
> Hi all,
> I'm in the process of fixing the HID descriptor for the PS3 Move
> Controller. which has a particularly convoluted layout for it's
> Accelormeters, Gyros and Magnetometers involving 2 sets of data per output
> report.
>
> https://github.com/nitsch/moveonpc/wiki/Input-report
>
> The plan is/was to massage the HID descriptor so the first set of
> Accels/Gyro/Mag appear in a set a axis, as a simple way of getting to this
> data.
>
> The Magnetometers are only 12 bits, and if 'we' want the HID system to be
> able to process these as an axis the data needs to be shuffled. Previously
> for the Sony SixAxis Accels was done in 'sony_raw_event'.
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/hid/hid-sony.c?id=refs/tags/v4.1-rc7#n1035
>
>
> My reshuffle would be:
> ---
>                  /* Need to fix order and shared nibble of 12bit Temp/Mags */
>                  /* 8e 4. .. .. .. .. -> Temp = 0x08E4 */
>                  /* .. .1 51 .. .. .. -> MagX = 0x0151 */
>                  /* .. .. .. 02 1. .. -> MagZ = 0x0021 */
>                  /* .. .. .. .. .2 98 -> MagY = 0x0298 */
>
>                  __u8 tmp;
>                  tmp = rd[38];
>                  rd[38] = (((rd[37] & 0xF0) >> 4) | ((rd[39] & 0x0F) << 4));
>                  rd[37] = (((tmp & 0xF0) >> 4) | ((rd[37] & 0x0F) << 4));
>                  rd[39] = (((rd[39] & 0xF0) >> 4) | ((tmp & 0x0F) << 4));
>
>                  tmp = rd[41];
>                  rd[41] = (((rd[40] & 0xF0) >> 4) | ((rd[42] & 0x0F) << 4));
>                  rd[40] = (((tmp & 0xF0) >> 4) | ((rd[40] & 0x0F) << 4));
>                  rd[42] = (((rd[42] & 0xF0) >> 4) | ((tmp & 0x0F) << 4));
> ---
>
> This works, however I have noticed that this affects/reshuffles the output
> of '/dev/hidraw0', which would 'corrupt' the data going into the existing
> user-mode drivers (such as psmoveapi).
>
> Is there a 'better' place/way to reshuffle this data, or is this just how
> it needs to be?
>
> Given that more controllers are coming with 'motion' controls, is there a
> framework in place for unifying support?
>
> Cheers,
> Simon.
>

Hmm, perhaps remove the mappings for the motion controls in the HID 
descriptor and add the motion axis flags in the input device creation 
callback as is currently done with the touchpad axes on the DS4.  Then 
you can parse the motion data and fire off motion events manually in the 
raw event function (again, same as the touch events on the DS4) and the 
raw data in the packet will pass through unchanged for userspace drivers.

Regards,
Frank
