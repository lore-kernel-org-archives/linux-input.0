From: Jaikumar Ganesh <jaikumarg@android.com>
Subject: Re: [PATCH] HID: magicmouse: ignore 'ivalid report id' while
 switching modes
Date: Tue, 23 Aug 2011 11:17:58 -0700
Message-ID: <CAA8bQNj2vvM1F_VEQAFyRRBSVb1LUJ8y3Af5iz3c+QHhBD7aTg@mail.gmail.com>
References: <1313611182-19924-1-git-send-email-jaikumarg@android.com>
 <4E4D3CFC.7000700@canonical.com> <CAA8bQNjQ2s4EY=2r455z-3r7yyV0uwSjhQ6m5g2+TCyMRvu0sQ@mail.gmail.com>
 <4E4D426F.607@canonical.com> <4E4D68B0.8000703@canonical.com>
 <CAA8bQNgOZTqGMZhHF0MOm25ZUD5_G0i9F=rMsCOdiD3DYAWhTw@mail.gmail.com> <alpine.LNX.2.00.1108231052220.13644@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:37962 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460Ab1HWSSU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Aug 2011 14:18:20 -0400
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com [172.24.198.85])
	by smtp-out.google.com with ESMTP id p7NIIJI6004592
	for <linux-input@vger.kernel.org>; Tue, 23 Aug 2011 11:18:19 -0700
Received: from qyk4 (qyk4.prod.google.com [10.241.83.132])
	by wpaz21.hot.corp.google.com with ESMTP id p7NIHv6x014900
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 23 Aug 2011 11:18:18 -0700
Received: by qyk4 with SMTP id 4so2237349qyk.20
        for <linux-input@vger.kernel.org>; Tue, 23 Aug 2011 11:18:18 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1108231052220.13644@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Chase Douglas <chase.douglas@canonical.com>, linux-input@vger.kernel.org

Hi Jiri,

On Tue, Aug 23, 2011 at 1:53 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Thu, 18 Aug 2011, Jaikumar Ganesh wrote:
>
>> I also tracked down two Apple magic trackpads - both with the same
>> Bluetooth version.
>> One which needs this patch (as it returns an invalid report id) and
>> the other which doesn't need this patch.
>> Both use the same device id.
>
> Gotta love hardware vendors indeed.
>
> So how about the patch below?
>
>
>
> From: Jiri Kosina <jkosina@suse.cz>
> Subject: [PATCH] HID: magicmouse: ignore 'ivalid report id' while swi=
tching modes, v2
>
> This is basically a more generic respin of 23746a6 ("HID: magicmouse:=
 ignore
> 'ivalid report id' while switching modes") which got reverted later b=
y
> c3a492.
>
> It turns out that on some configurations, this is actually still the =
case
> and we are not able to detect in runtime.
>
> The device reponds with 'invalid report id' when feature report switc=
hing it
> into multitouch mode is sent to it.
>
> This has been silently ignored before 0825411ade ("HID: bt: Wait for =
ACK
> on Sent Reports"), but since this commit, it propagates -EIO from the=
 _raw
> callback .
>
> So let the driver ignore -EIO as response to 0xd7,0x01 report, as tha=
t's
> how the device reacts in normal mode.
>
> Sad, but following reality.
>
> This fixes https://bugzilla.kernel.org/show_bug.cgi?id=3D35022
>
> Reported-by: Chase Douglas <chase.douglas@canonical.com>
> Reported-by: Jaikumar Ganesh <jaikumarg@android.com>
> Tested-by: Chase Douglas <chase.douglas@canonical.com>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
> =A0drivers/hid/hid-magicmouse.c | =A0 10 +++++++++-
> =A01 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmous=
e.c
> index b5bdab3..f0fbd7b 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -537,9 +537,17 @@ static int magicmouse_probe(struct hid_device *h=
dev,
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0report->size =3D 6;
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Some devices repond with 'invalid report id' when =
feature
> + =A0 =A0 =A0 =A0* report switching it into multitouch mode is sent t=
o it.
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* This results in -EIO from the _raw low-level trans=
port callback,
> + =A0 =A0 =A0 =A0* but there seems to be no other way of switching th=
e mode.
> + =A0 =A0 =A0 =A0* Thus the super-ugly hacky success check below.
> + =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0ret =3D hdev->hid_output_raw_report(hdev, feature, siz=
eof(feature),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HID_FEATURE_REPORT);
> - =A0 =A0 =A0 if (ret !=3D sizeof(feature)) {
> + =A0 =A0 =A0 if (ret !=3D -EIO && ret !=3D sizeof(feature)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hid_err(hdev, "unable to request touch=
 data (%d)\n", ret);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_stop_hw;
> =A0 =A0 =A0 =A0}
> --
> 1.7.3.1
>
>

Tested. Please push.

Thanks
Jaikumar
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
