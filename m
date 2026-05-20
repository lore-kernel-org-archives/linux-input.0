Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3964A8003D
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 02:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779245477; cv=none; b=rqHfk+8dr/AbPcHHPQhMGMzrmNDmGdpzUQuv1BoMtMClUuuS4n4bbG7gem8tKaYmRzib3BuARYaHT+3QRw92KTA72rVwTsVV0gGFZsyRImlY1C8TUDAfbMsgRxGrb4MjZw7zWdfoJTfLjsh9bNda2ATVrdd9GwcAM2IGUafcmc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779245477; c=relaxed/simple;
	bh=DnT0rWAsJf6VviKWQGSjKP71M+HH9iS2np3UdELsyw8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hGL3MJXUd23fIuk/nfJBxUEd/C9v/phM/iVZJxOJxt5pkA7SaY80sQzNnPBC8jsFRgRfr2K5HbTM2eQ6XdrvYMNX++PzCa0sj7Zp/cHO8fswSt65LftC3PNEQoBQhMlp/JGn1mCby6dPvTCWijFUXplxqhZpvZU5Yc+5pTQYgY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocMac7uy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocMac7uy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFD01F000E9;
	Wed, 20 May 2026 02:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779245476;
	bh=LjYj6TzAocIMKbu4j2nPcnUcF5jfC4QdSmnvdADM4uk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ocMac7uyO3qzdf/B2AyHW8XjwZPIwQVX5j96t8yUjbGqNRJc/Np3NtTml/PIGP2YV
	 kvqjg2kkkx2L+EFZ6DQeuGq3TO3+DskcTpStNa7mKSUUQMeZsbkPgz2joOXN0ts8un
	 /j+zzZMT0A8oXoGZ8sfjpKzgbXTRsdHpv80L8g9xEi8quaQuuzY1ZjUNRjmM6djv38
	 cul1RrGbYzx5qi0q/NRXw/Ap7DwPGJORCZSOTCJhA0qYt0FpQjlRILV7LGz1End5XO
	 o7WWEPm/X4WFxb7hLVh0EMSfcMtGwwhy3xF7YCz/TDEkAp51V3ftfJUGbaj2bDJ8Mf
	 JlZGhhMvapu0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/4] HID: hid-msi: Add M-key mapping attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260520013158.3633277-3-derekjohn.clark@gmail.com>
References: <20260520013158.3633277-3-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 02:51:15 +0000
Message-Id: <20260520025115.CFFD01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] A stale or late `READ_PROFILE_ACK` packet will abort an active, le=
gitimate `READ_PROFILE` command.
- [High] A Time-Of-Check to Time-Of-Use (TOCTOU) race in `claw_profile_even=
t()` can clobber a newly set `profile_pending` state.
- [High] The driver sends the `SYNC_TO_ROM` command without waiting for its=
 ACK, intentionally leaving an unconsumed ACK in the pipeline.
- [Low] Early error returns leave `drvdata->profile_pending` in a dangling =
state.

Pre-existing issues:
- [High] Generic ACKs (`CLAW_COMMAND_TYPE_ACK`) unconditionally complete an=
y active wait, undermining synchronization guarantees.
--

commit ea147cb0c22726417b3bcecf39e1edbaa79122af
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add M-key mapping attributes

Adds sysfs attributes to allow remapping the M-keys with up to 5 values whe=
n in
macro mode. The driver maps gamepad buttons, keyboard keys, and mouse event=
s,
using device endpoints or event devices depending on the mapping type.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index d95483907a5e5..193435ec9386c 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> @@ -136,6 +320,39 @@ static int claw_gamepad_mode_event(struct claw_drvda=
ta *drvdata,
>  	return 0;
>  }
> =20
> +static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_=
command_report *cmd_rep)
> +{
> +	enum claw_profile_ack_pending profile;
> +	struct claw_mkey_report *mkeys;
> +	u8 *codes, key;
> +	int i;
> +
> +	scoped_guard(spinlock, &drvdata->profile_lock)
> +		profile =3D drvdata->profile_pending;
> +
> +	switch (profile) {
> +	case CLAW_M1_PENDING:
> +	case CLAW_M2_PENDING:
> +		key =3D (profile =3D=3D CLAW_M1_PENDING) ? CLAW_KEY_M1 : CLAW_KEY_M2;
> +		mkeys =3D (struct claw_mkey_report *)cmd_rep->data;
> +		if (be16_to_cpu(mkeys->read_addr) !=3D drvdata->bmap_addr[key])
> +			return -EINVAL;

[Severity: Low]
If this returns early because of an address mismatch, will profile_pending =
be
left in a dangling state instead of being cleared to CLAW_NO_PENDING?

[ ... ]

> +	default:
> +		dev_dbg(&drvdata->hdev->dev,
> +			"Got profile event without changes pending from command: %x\n",
> +			cmd_rep->cmd);
> +		return -EINVAL;
> +	}
> +	scoped_guard(spinlock, &drvdata->profile_lock)
> +		drvdata->profile_pending =3D CLAW_NO_PENDING;

[Severity: High]
Can a concurrent sysfs read overwrite the profile_pending state during the
window between releasing and re-acquiring the lock?

If another CPU acquires the lock and sets a new state, such as CLAW_M2_PEND=
ING,
won't this unconditionally overwrite that new state with CLAW_NO_PENDING and
break the subsequent command's wait?

> +
> +	return 0;
> +}

[ ... ]

> @@ -166,6 +383,19 @@ static int claw_raw_event(struct claw_drvdata *drvda=
ta, struct hid_report *repor
>  			}
>  		}
> =20
> +		break;
> +	case CLAW_COMMAND_TYPE_READ_PROFILE_ACK:
> +		ret =3D claw_profile_event(drvdata, cmd_rep);
> +
> +		scoped_guard(spinlock, &drvdata->cmd_lock) {
> +			if (drvdata->waiting_for_ack &&
> +			    drvdata->waiting_cmd =3D=3D CLAW_COMMAND_TYPE_READ_PROFILE) {
> +				drvdata->cmd_status =3D ret;
> +				drvdata->waiting_for_ack =3D false;
> +				complete(&drvdata->send_cmd_complete);
> +			}
> +		}
> +
> +		break;

[Severity: High]
If a late or stale READ_PROFILE_ACK arrives during an active READ_PROFILE
command wait, it will cause claw_profile_event() to return -EINVAL.

Will this unconditionally assign the -EINVAL to cmd_status and complete
the wait prematurely, aborting the active valid command instead of ignoring
the mismatched ACK?

>  	case CLAW_COMMAND_TYPE_ACK:
>  		scoped_guard(spinlock, &drvdata->cmd_lock) {
>  			if (drvdata->waiting_for_ack) {
>  				drvdata->cmd_status =3D 0;
>  				drvdata->waiting_for_ack =3D false;
>  				complete(&drvdata->send_cmd_complete);
>  			}

[Severity: High]
This is a pre-existing issue, but does this generic ACK handler blindly
complete any active wait without checking drvdata->waiting_cmd?

If a generic ACK arrives while a command like READ_PROFILE is actively
waiting for a specific data payload, the generic ACK will fulfill the wait
early with a success status, causing the caller to falsely assume the read
succeeded and consume stale data.

[ ... ]

> @@ -433,6 +663,173 @@ static ssize_t reset_store(struct device *dev, stru=
ct device_attribute *attr,
>  }
>  static DEVICE_ATTR_WO(reset);
> =20
> +static int mkey_mapping_name_to_code(const char *name)
...
> +static int claw_mkey_store(struct device *dev, const char *buf, u8 mkey)
> +{
...
> +set_buttons:
> +	scoped_guard(mutex, &drvdata->rom_mutex) {
> +		ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DA=
TA,
> +					    (u8 *)&report, sizeof(report), 25);
> +		if (ret)
> +			return ret;
> +		/* MCU will not send ACK until the USB transaction completes. ACK is s=
ent
> +		 * immediately after and will hit the stale state machine, before the =
next
> +		 * command re-arms the state machine. Timeout 0 ensures no deadlock wa=
iting
> +		 * for ACK that ill never come.
> +		 */
> +		ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NUL=
L, 0, 0);

[Severity: High]
Since this sends SYNC_TO_ROM with a timeout of 0, doesn't it intentionally
leave an unconsumed ACK in the pipeline?

Because the generic ACK handler doesn't check waiting_cmd, won't this
delayed ACK unconditionally complete the next command issued to the device
that waits for a response, such as claw_mkey_show(), breaking the host-devi=
ce
synchronization?

> +	}
> +
> +	return ret;
> +}
> +
> +static int claw_mkey_show(struct device *dev, char *buf, enum claw_key_i=
ndex m_key)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct claw_mkey_report report =3D { {0x01, cpu_to_be16(drvdata->bmap_a=
ddr[m_key])}, 0x07 };
> +	int i, ret, count =3D 0;
> +	const char *name;
> +	u8 *codes;
> +
> +	/* Pairs with smp_store_release from cfg_setup_fn in system_wq context =
*/
> +	if (!smp_load_acquire(&drvdata->gamepad_registered))
> +		return -ENODEV;
> +
> +	codes =3D (m_key =3D=3D CLAW_KEY_M1) ? drvdata->m1_codes : drvdata->m2_=
codes;
> +
> +	guard(mutex)(&drvdata->profile_mutex);
> +	scoped_guard(spinlock_irqsave, &drvdata->profile_lock)
> +		drvdata->profile_pending =3D (m_key =3D=3D CLAW_KEY_M1) ? CLAW_M1_PEND=
ING
> +								  : CLAW_M2_PENDING;
> +
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_PROFILE,
> +				    (u8 *)&report, sizeof(report), 25);
> +	if (ret)
> +		return ret;

[Severity: Low]
If claw_hw_output_report() fails, such as due to a timeout, does this early
return leave profile_pending in a dangling state instead of clearing it
back to CLAW_NO_PENDING?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520013158.3633=
277-1-derekjohn.clark@gmail.com?part=3D2
