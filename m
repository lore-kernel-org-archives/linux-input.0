Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794652172;
	b=zZE9YgZ5qLzXsMbGa08uUYMB3SCdqHS/VWqZXv51z4f9CVGMHZfa7SvLg0/zEL4G+Mu8
	 +aAVc65j+aik4zaDoA9tghdv1HIdr2txi3raZQAKpSOLDSy2oJRhcKFTJ/HHw7DSPELDA
	 K0pFryE/7PQTpQ3jrZCvBGmDEEkg7uyKHX1n4FmjMqX5P+pXdJ0TCZ6DTATXWoxXOwLPn
	 z9IWtOgUac9BeqwUWu0GRYIS2/vCkX2k606djbyNEl4j5Q82WpTyx2XIkZzKnrUdTQdhk
	 /iloNKHtVLPMR0OZhhDiXNn+FbPZWZ7g5A0zGcE+JEzuXOBJH79jce3YueiwAWSPGHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794652172;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GEwdeK+QYJKXg40Uf8SMvZ+S7Vp/JjV1iwnB7oYToS4=;
	b=mrEHL8BQOd+jN4Hk7ccP88b0NR+G9NAsStatEA4Jps+0c9gKit0WeY+gs9IAAojArB1p
	 Bgs6u4nYrAVhD2Q+1bRE9l5A5iQn9P6FrotYLG0sIMmDI1Lu9N6gngFO86Lnpj067PxAe
	 ymKUWgy39OXA8Nxd1YrC9GZL+gWd12Ud/n0igZIBZGC76Wmgmwgv4gCnqLvMPctfYSWp/
	 xLhdBVVVXLq1U1BNQwkSQydEoOn9/0eQHIjz+9fanrHvieqazWiPRcA96+naUB1q22HHc
	 DRQbWWwyT29Ie5+LS1jzFmh95Kkfc6rb9GXmff8xcqW92laVuLAyh/Oh1L9aLb1Gg8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDHGfYRP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45607606A327
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDHGfYRP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEF61F000C4;
	Sat, 14 Nov 2026 10:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794652172;
	bh=GEwdeK+QYJKXg40Uf8SMvZ+S7Vp/JjV1iwnB7oYToS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jDHGfYRP+D6b0A3EbF1yWfysUF7JI5Ym3Tle/uw8fCpbPjLN6Ij3Mlz8bZIeBYRbx
	 gT8raBaKyd6rFrFdaG0AecPyQgTm5zB2n0Nqgzdul3DhjeNdzI/0VQhnQNxJEB1ogT
	 OPuRUReiGi9Lw6xd81HPUntLd8MVbRzPnGtfIOP+YXyXAToZmESrmA+azOhCUU5+vV
	 Y0j5xjKTVl/MimKp7aB4AgrwsT1FJuDoqVUV+4uu6hZB2nXB14A2vT9Ofh19vTWVq8
	 2D/WMPgArVSZiK1r43ipE7uCFWxHrx/5+ihDXUeG90p9MMIxOizFG7MAMOGlaVDCLv
	 f2qDTrHp+eCQg==
Message-ID: <sashiko-outbox-214360@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: hid-msi: Drain orphan MCU ACKs by issuing a query
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kenhou Iijima" <kenhou@kenhou.net>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261114101045.21986-1-kenhou@kenhou.net>
References: <20261114101045.21986-1-kenhou@kenhou.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 10:29:31 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] HID: hid-msi: race in claw_suspend() lets orphan_ack_work run
  after suspend
- [Medium] HID: hid-msi: orphan ACK in claw_raw_event() completes read
  commands early
--

commit d1c0d0f5c28e7bbec3449fd155157b8c3178c746
Author: Kenhou Iijima <kenhou@kenhou.net>

HID: hid-msi: Drain orphan MCU ACKs by issuing a query

This commit schedules a work item to issue a READ_GAMEPAD_MODE query when an
unexpected ACK arrives from the MSI Claw MCU so the MCU stops re-sending the
pending ACK.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 23d731f700c90..e52923fcc8260 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> @@ -532,7 +533,12 @@ static int claw_raw_event(struct claw_drvdata *drvda=
ta, struct hid_report *repor
>  		}
> =20
>  		if (drvdata->waiting_cmd =3D=3D CLAW_COMMAND_TYPE_NONE) {
> -			dev_warn(&drvdata->hdev->dev, "Got unexpected ACK from MCU, ignoring\=
n");
> +			/*
> +			 * The MCU re-sends an unhandled ACK roughly every 2 s
> +			 * until it receives another command. Drain it by
> +			 * scheduling a harmless query so the ACK storm stops.
> +			 */
> +			schedule_work(&drvdata->orphan_ack_work);
>  			break;
>  		}

[Severity: Medium]
Can an orphan CLAW_COMMAND_TYPE_ACK arriving while a read command is in fli=
ght
complete drvdata->send_cmd_complete early?

__claw_hw_output_report() sets drvdata->waiting_cmd to
CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE or CLAW_COMMAND_TYPE_READ_PROFILE before
transmitting the request.  If a re-transmitted CLAW_COMMAND_TYPE_ACK arrives
before the read response (CLAW_COMMAND_TYPE_GAMEPAD_MODE_ACK or
CLAW_COMMAND_TYPE_READ_PROFILE_ACK), waiting_cmd is not
CLAW_COMMAND_TYPE_NONE, so claw_raw_event() falls through, sets
drvdata->cmd_status =3D 0, and completes drvdata->send_cmd_complete.  Calle=
rs
such as gamepad_mode_show() and claw_mkey_show() then return stale or
uninitialized data while leaving drvdata->profile_pending set.

In addition, when the initial ACK for a timeout-0 command arrives with
drvdata->orphan_ack_pending set, the earlier branch clears orphan_ack_pendi=
ng
and breaks without scheduling orphan_ack_work, leaving the MCU's pending ACK
state undrained so it still re-transmits 2 seconds later.

> @@ -653,6 +659,20 @@ static int claw_hw_output_report(struct hid_device *=
hdev, u8 index, u8 *data,
>  	return __claw_hw_output_report(hdev, index, data, len, timeout);
>  }
> =20
> +static void claw_orphan_ack_drain(struct work_struct *work)
> +{
> +	struct claw_drvdata *drvdata =3D container_of(work, struct claw_drvdata,
> +						    orphan_ack_work);
> +
> +	/*
> +	 * A query is enough to make the MCU stop re-sending the pending ACK.
> +	 * claw_hw_output_report() also waits for any orphan ACK before
> +	 * sending, so this cannot interleave with a real command sequence.
> +	 */
> +	claw_hw_output_report(drvdata->hdev, CLAW_COMMAND_TYPE_READ_GAMEPAD_MOD=
E,
> +			      NULL, 0, 25);
> +}

[ ... ]

> @@ -2014,6 +2036,7 @@ static int claw_suspend(struct hid_device *hdev)
> =20
>  	cancel_delayed_work_sync(&drvdata->cfg_resume);
>  	cancel_delayed_work_sync(&drvdata->cfg_setup);
> +	cancel_work_sync(&drvdata->orphan_ack_work);
>  	cancel_delayed_work_sync(&drvdata->rgb_queue);
> =20
>  	return 0;

[Severity: Medium]
Can claw_raw_event() re-schedule drvdata->orphan_ack_work after claw_suspen=
d()
cancels it?

In drivers/hid/usbhid/hid-core.c, hid_suspend() runs hid_driver_suspend()
before hid_cease_io() stops usbhid->urbin, and claw_suspend() also cancels
orphan_ack_work before cancel_delayed_work_sync(&drvdata->rgb_queue) (where
claw_rgb_queue_fn() sends CLAW_COMMAND_TYPE_SYNC_TO_ROM with timeout 0):

CPU0                              CPU1
hid_suspend()
  ...
  claw_suspend()
    cancel_work_sync(&drvdata->orphan_ack_work)
                                  claw_raw_event()
                                    schedule_work(&drvdata->orphan_ack_work)
    cancel_delayed_work_sync(&drvdata->rgb_queue)
  ...
  hid_cease_io(usbhid)
                                  claw_orphan_ack_drain()
                                    claw_hw_output_report()
                                      ...
                                      usb_interrupt_msg()  <-- I/O while su=
spended

Because nothing prevents claw_raw_event() from queueing orphan_ack_work dur=
ing
suspend, claw_orphan_ack_drain() can run and issue synchronous USB output
transfers against a suspending or already-suspended device after usbhid->ur=
bin
has been stopped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114101045.2198=
6-1-kenhou@kenhou.net?part=3D1
