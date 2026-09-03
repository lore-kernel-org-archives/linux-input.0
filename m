Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84282361979
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788475018; cv=pass; b=LVK6wDLjRPE/zTlOWUIIIhsw6JoFGmRFEFpBc/KyoQMrLP3IwcMAfRoL6M6N8xlRelzCUT3ft1FkTABbjaZ9SaRSLIkhXwo3A2tbdg5hj287YcC7nA6Z5noAkAiKgcmTQ0cDsnPf488vARI2kxGbOhJW/8/QKthBbCLmSshHp2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788475018; c=relaxed/simple;
	bh=mFiJ08W4a5OBXJwVwrhjRDGXwqW9MrIAwZAygtDyiuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPFZJ+QMHu45Bhf1/TT1or4wkvLWBtucy0UIwFevqW7EWTAxJN5Swml9tvcuVejPhpHC949RTKDJcUntgQ8rSHiOxwkO3PHxyLWEG9FN5tKIPDXpGoCtwNPcfiS40fHUuXStODF4Zablp4jl3GesZBV+mIsrNMN9giJX36usikM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTVom41g; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTVom41g"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-90ce3971a86so4924586d6.0
        for <linux-input@vger.kernel.org>; Thu, 03 Sep 2026 15:36:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788475015; cv=none;
        d=google.com; s=arc-20260327;
        b=dXUk36QGgNouD5MHP+lg/gSRUilNGyDhpciSmKH3kv6VybmMjjcxz06YEdLP36wFJd
         Yamnvc5MBwZJ0zBkmtHwTDTGPpYih3fpN4mFapawBolrXjJ5iWQ7hHb0IVc2sXvGPQ2G
         4IEFcCMoJ5K0NL9gh0U5gKqRae9KpiOa7kjEMRp3jdb1aurBG48/69j9rendg9NKcYPJ
         LDhjDhbqARp+gQ1fY8HcJZt9ONF/6Jn4t/QLLvwkw1U3NTNd/pv4sZRxlrevd+DaensT
         0OooFAKW/Lz2ziFuRIODfvw7l/l3XYdTN4UIgpJ8fE4VAKb91MZc7IHrUmeefXGDu5NT
         IlwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LLwHncsTbuxPzx5yYNEBeAPEkhiwNDT/H784knECcqk=;
        fh=RXmTlq8NOfIf7bnU2C7LwHpEY72bRqcA1gmVDmkZaYk=;
        b=ct9UqrmwleX4pTmXRXxhd19TRFYJGAqYO6+FLaAQfUBxVnonqOetWsk7Gec8X7w9Qz
         Aj5psTYe+4H9zazZ9cKjBx7q55H46wbJa9J2EbW24MH3Df7sQRJ5mttuTkpMQjGJPbvm
         ZseKhT1YGB7CVN8NddqsOWuTJaK7LcA0RGHQuwGOAUXc/neUZiWJ4MlCwor7sCSrHOY/
         kVGROr659fSOX9C2GXR8iglO+pmP+/LbBIkhLo9eBgNxEcSmXtenLx2enYTwh0yqtQ8F
         92bk8n58JYNUCzzcyf0lxNv0rnfg9BBHdvBgTn0TKZUbF6mcn6OXPAOwFeg3Xxfyryku
         KDdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788475015; x=1789079815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LLwHncsTbuxPzx5yYNEBeAPEkhiwNDT/H784knECcqk=;
        b=jTVom41gTJ/QUY33W75BX5Laj9qV7Bhvb40FlPApjflL2RVqYMRK7VzUoZhyYzKuht
         mEdP32TX9LBhVGEMqeJgoCUP6iIaGcnwAdYpuG5HLRMRtcwOw2cPI2izdPm0w//U4S1R
         vbv+pwnCQ7Ol5w+0/iUSscvDkx8k1fCnel8HMHhNxfYNpLgqI1wNl+SS0qgBlmfR4Vp3
         v6GHEF6YCLsYqRP1qMgTmt8s8gM6FLpmMp6xrOODRSgy29Wi/qFkfi0/46g2JnV/r0RF
         P2NMKzutLHt8ecRXmYLn0nwlVZigqBzvH4FQpTRFeRYfbGD71ADZRk4BUwXXRijY0lLt
         tasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788475015; x=1789079815;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LLwHncsTbuxPzx5yYNEBeAPEkhiwNDT/H784knECcqk=;
        b=FwTxJtCQKxO0p5nxZns/Ce7aqay9S3GDzQ67GkN24f7xNbAgDD+963cC/g2jN2FBH3
         MpSmbfxmyp0r+NqMDnWC+0BZyGnXQ4la8WTW3s6qjbemqXB5A6kjF/+NbfkIPG1I7rQf
         kPD+WTfCZvb2IjKuZ8cA8qdaQBvV0pky6n+yAXdW3Ox9mgXKQONEB63+uGCAzJz8q2NL
         pP9x4rhHW8kXo1IXAJ2lqf5mmibwTM+NqqxPbyQsPZlO2rxTf9W2GuU/5Rm4po+YJxz3
         UzFNJmdiFo5zyHJOM9j7RO5VeNHJnRX4XRIshnbQwNriVcz5uX+Bv35nBeQd/NVdFueT
         lpwQ==
X-Forwarded-Encrypted: i=1; AKwUvBwSWSQC8tMjdTxTSrke3eiWpmm+m1Or75TthymuS3m0lNJoJ87DrgL1V+QcR/4hV7G373yGJxtk5TUeCQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nC6CGgsrfuphwmnOHlAn4wP6JkvZ+PvMWfgBLDKcituse0LDYh
	CNfDRxs+sVAAjTCsGl3dhReaSxB4nc4m8WspOrmjwh+CdAsdtEio0eu0frEd6N+U8ONfACDPeS3
	qDeMgEhkt9cCXJrl7I0LAx10R+Tt2gw6xUWI9
X-Gm-Gg: AYBFou1q6QDIINhcb9KXlUCSQvzWOX6xhP70nexiHZVom/0VSbxlOva+glOLR0iW6wm
	qK6z2u89rNiWRh/T5eEQAw8rT+yysYMiqWLGsfgAjjw4t/DcssXcQkQ/uor72OnWraAnGn04kWA
	PqVS+K2mviCllhL4UJrPmPmIE2RsfIJ4PbktCyUr8HDG/dUb3KJ5ch3flnyoOKONIvJS3oZUicU
	JYJfjmaUdPeOa3gOEqmkwBJ/njihb9qeJzjU72Sf1/3TrvjT7/Ntken6vXOP7rcvi0JK5qcCpXx
	oLgB1WpYtGuVPPp3Q6Zw1mn9fu7dZn2mkpawa1gc6Ffg
X-Received: by 2002:a05:6214:3389:b0:910:39e7:dbb9 with SMTP id
 6a1803df08f44-9103efbf07dmr36517936d6.33.1788475015314; Thu, 03 Sep 2026
 15:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANRwn3TWTHxP=ZEpgZzjRweC8vqifoi2koKgSQTEuPuY4FZxcQ@mail.gmail.com>
 <20260828033323.82958-1-98lawweijie@gmail.com>
In-Reply-To: <20260828033323.82958-1-98lawweijie@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Thu, 3 Sep 2026 15:36:44 -0700
X-Gm-Features: AcwNN1Uf8W0B_NasShubMPyX2tl_dv_s_spNFLKUekhbNr4EO8bPhewHWVRjrA8
Message-ID: <CANRwn3RFVDy+y-fpLkb1mfjiKyQgp1Jg0tyBTO+G0xem2s1jkQ@mail.gmail.com>
Subject: Re: [PATCH v3] HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()
To: Wei Jie LAW <98lawweijie@gmail.com>
Cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 8:33=E2=80=AFPM Wei Jie LAW <98lawweijie@gmail.com>=
 wrote:
>
> From: Wei Jie Law <98lawweijie@gmail.com>
>
> wacom_wac_pen_serial_enforce() iterates over a field's usages (up to
> field->maxusage) but indexes the report bits by j * report_size, the
> position of value slot j -- and only the field->report_count value
> slots reserved by the Report Count exist in the report:
>

Thanks for the v3!

I'm still finding the above paragraph kinda hard to understand. What
do you think of something like the following instead?

* * * *

The 'wacom_wac_pen_serial_enforce' function may calculate and pass an
invalid offset to 'hid_field_extract', resulting in memory reads at
incorrect addresses--possibly beyond the end of the report. If a field
in the HID descriptor lists more usages than its Report Count actually
reserves space for, the function's inner 'j' will walk past the end of
the field:

* * * *

Other than the above language issue:
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

>         for (i =3D 0; i < report->maxfield; i++) {
>                 for (j =3D 0; j < report->field[i]->maxusage; j++) {
>                         ...
>                         value =3D hid_field_extract(hdev, raw_data + 1,
>                                                   offset + j * size, size=
);
>
> hid_add_field() sizes the usage array with max(usage_index,
> report_count), so a report descriptor can declare far more usages
> than its Report Count reserves room for in the report.  One listing
> 12288 usages against Report Count 1 has the loop extract the usage
> at index 12287 from bit offset 98296 -- about 12 KB past a 2-byte
> received report.  The value is stored in wacom_wac->serial[0] and
> can reach userspace as an MSC_SERIAL event, making this an
> information disclosure.
>
> Clamp the loop to field->report_count, the number of value slots the
> report holds. Value slots past the last declared usage are still
> scanned; they reuse that usage (HID 1.11, 6.2.2.8).
>
> Verified on v6.12.105 with a UHID reproducer: a 2-byte report from
> such a descriptor trips KASAN before the patch and not after it.
>
> Fixes: 83417206427b ("HID: wacom: Queue events with missing type/serial d=
ata for later processing")
> Suggested-by: Jason Gerecke <killertofu@gmail.com>
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Assisted-by: GLM:glm-5.3
> Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
> ---
> Changes in v3, per Jason Gerecke's review:
>
>  - reworded the explanation: the usage array is sized for maxusage;
>    the descriptor just declares more usages than its Report Count
>    reserves room for in the report, and the loop trusted maxusage
>    over report_count
>
>  - bound inner loop to field->report_count
>
> The reproducer is available on request.
>
> Compile-tested on 6ba2c27cb9aa (x86_64, wacom_sys.o); the runtime
> verification used the identical wacom_sys.c built as a module for
> v6.12.105.
>
> v2: https://lore.kernel.org/linux-input/20260825103104.12090-1-98lawweiji=
e@gmail.com/
> v1: https://lore.kernel.org/linux-input/20260822120926.153849-1-98lawweij=
ie@gmail.com/
>
>  drivers/hid/wacom_sys.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 0eafa483b7f7..40770affdbde 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -113,8 +113,9 @@ static int wacom_wac_pen_serial_enforce(struct hid_de=
vice *hdev,
>
>         /* Queue events which have invalid tool type or serial number */
>         for (i =3D 0; i < report->maxfield; i++) {
> -               for (j =3D 0; j < report->field[i]->maxusage; j++) {
> -                       struct hid_field *field =3D report->field[i];
> +               struct hid_field *field =3D report->field[i];
> +
> +               for (j =3D 0; j < field->report_count; j++) {
>                         struct hid_usage *usage =3D &field->usage[j];
>                         unsigned int equivalent_usage =3D wacom_equivalen=
t_usage(usage->hid);
>                         unsigned int offset;
> --
> 2.43.0
>
