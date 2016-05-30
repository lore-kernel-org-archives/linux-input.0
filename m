From: mail@m-reimer.de
Subject: Re: [PATCH] hid-sony: Prevent crash when rumble effects are still loaded at USB disconnect
Date: Mon, 30 May 2016 06:45:32 +0200
Message-ID: <0F0640EB-1D5E-40F5-A422-45BCBE62DAA7@m-reimer.de>
References: <a9a2689b-5af7-9676-67fd-5d911fcc9501@m-reimer.de> <856C5FBA-EA87-4D24-BB29-433FF5437518@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:52128 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890AbcE3Epr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 30 May 2016 00:45:47 -0400
In-Reply-To: <856C5FBA-EA87-4D24-BB29-433FF5437518@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>, Manuel Reimer <mail+linux-input@m-reimer.de>
Cc: linux-input <linux-input@vger.kernel.org>, jikos@kernel.org

Am 29. Mai 2016 19:11:45 MESZ, schrieb Cameron Gutman <aicommander@gmai=
l.com>:
>
>> On May 29, 2016, at 7:11 AM, Manuel Reimer
><mail+linux-input@m-reimer.de> wrote:
>>=20
>> Hello,
>>=20
>> I had a deeper look at the kernel panic, happening if there are
>rumble effects loaded and the USB plug is pulled.
>>=20
>> The reason for this is similar to the one, I fixed in uinput some
>days ago.
>>=20
>> In "sony_remove" the memory for "output_report_dmabuf" is freed.
>> Then, a few lines later, "hid_hw_stop" is called.
>> This now tries to cleanup and causes ff_memless to try to send out a
>new rumble event which should turn both motor speeds to zero.
>> To get this processed, "sc->send_output_report" is called, which, fo=
r
>example, ends up in "dualshock4_send_output_report".
>> This function will now use the, already freed,
>"output_report_dmabuf".
>>=20
>> My patch zeroes out "output_report_dmabuf" after freeing and checks
>for this in the "send_output_report" functions. There may be other way=
s
>to fix this, so please tell me if you prefer some other way.
>>=20
>> I've added a one-line comment above the memory pointer check, as, in
>my opinion, it is not obvious what is happening here.
>>=20
>> Signed-off-by: Manuel Reimer <mail@m-reimer.de>
>>=20
>> --- a/drivers/hid/hid-sony.c	2016-05-13 16:13:00.339346161 +0200
>> +++ b/drivers/hid/hid-sony.c	2016-05-29 13:54:25.452029787 +0200
>> @@ -1809,6 +1809,10 @@ static void sixaxis_send_output_report(s
>> 		(struct sixaxis_output_report *)sc->output_report_dmabuf;
>> 	int n;
>>=20
>> +	/* If called via hid_hw_stop, then our memory is already gone! */
>> +	if (!report)
>> +		return;
>> +
>> 	/* Initialize the report with default values */
>> 	memcpy(report, &default_report, sizeof(struct
>sixaxis_output_report));
>>=20
>> @@ -1853,6 +1857,10 @@ static void dualshock4_send_output_repor
>> 	__u8 *buf =3D sc->output_report_dmabuf;
>> 	int offset;
>>=20
>> +	/* If called via hid_hw_stop, then our memory is already gone! */
>> +	if (!buf)
>> +		return;
>> +
>> 	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
>> 		memset(buf, 0, DS4_REPORT_0x05_SIZE);
>> 		buf[0] =3D 0x05;
>> @@ -1899,6 +1907,10 @@ static void motion_send_output_report(st
>> 	struct motion_output_report_02 *report =3D
>> 		(struct motion_output_report_02 *)sc->output_report_dmabuf;
>>=20
>> +	/* If called via hid_hw_stop, then our memory is already gone! */
>> +	if (!report)
>> +		return;
>> +
>> 	memset(report, 0, MOTION_REPORT_0x02_SIZE);
>>=20
>> 	report->type =3D 0x02; /* set leds */
>> @@ -2426,6 +2438,7 @@ static void sony_remove(struct hid_devic
>> 	sony_cancel_work_sync(sc);
>>=20
>> 	kfree(sc->output_report_dmabuf);
>> +	sc->output_report_dmabuf =3D NULL;
>
>What prevents one of the send_output_report() functions from accessing
>sc->output_report_dmabuf after it=E2=80=99s been passed to kfree() but=
 before
>you=E2=80=99ve set it to NULL? Why not simply wait to free output_repo=
rt_dmabuf
>until after hid_hw_stop returns?


Good point! But I'm unsure how these workqueues work in kernel. Isn't i=
t possible that send_output_report is called after sony_remove already =
finished executing (still a task in queue) and so the already freed mem=
ory is accessed, again?

>
>>=20
>> 	sony_remove_dev_list(sc);
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
