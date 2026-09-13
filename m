Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90E025B0A5
	for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789334216; cv=pass; b=oUbD1A/S8y8xbzuDMEDIEdxPQG54yrt7XxPgB0OyjXEoTx08BQ8Lj0+NxtjjsICUoAWCGc2NAY3eg+K0RtxS6jsiBYry0OReYTeWweB2mItmymvV51koQ5RLyQKRLFuT0XV4jsoyyKvgNGSkohh6CNohs7zB0r0RAGw0D2seqxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789334216; c=relaxed/simple;
	bh=wFOh7QburwtUJ1m6fCJ3H06yEyE2mZRVq2IZKXbp/Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPyV9XaAqMgSLEnYXqBc/HNm1J5aHET+PsBxOCVBYzlu3rhtEghWTjCkFSycjtdyz01wBk7RMvrGzj6ZqKR9hdajuFiOJHcjpXX9jTFXgHCpQ05akAcrJh6pYkUCexojroMP6EkFgEiDFOXwWzlWl/pspq9Tna5cM/jIwm0nLYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSW1kBeD; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSW1kBeD"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcc3e14so6137386d6.0
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 14:16:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789334213; cv=none;
        d=google.com; s=arc-20260327;
        b=J1yNfFs72ePBRbjfOz21s0KJm16Bh8Am+z0GX4mJN3BDSE4nj8VupIUveiv0dKYqjJ
         N9y8Hucow41LenyEbG+IbNru7hxMbqTmcMeL8hAnV/2BmHPzPLQNLNEkRvvwKJA06eRG
         6+VexJvLNoso+V/8pox8vPu0lpQIwIRaQ0vjHU1oG9uljulBNVuVoaVAu0SmUjOd1coB
         UIAyc5D8a+XXHotQy15xDqXH7mXSYR8KR50Qva+W/ECk9EU4LVyrHrLvt3yZ0b4UNrv/
         s2VwypxBrAbNP/Mnk0+4TFV4bbo5/JFoJqHIx86JSTaVE+ZZTKPrOPfbei/sQionmkQ6
         dPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cFkJlLROUmPxlY1gP0B5QhtPVhWh5/pBnHlPJP1GJfA=;
        fh=7WoZ8OMiw05fHT1rxGY1tcYFkPh6bVJS6UxLFWDIlyI=;
        b=W2ojaAtRu6ApKkJATkAEYviTRy3qmRpwFJAz0yiFq0RufBxVqTtDT/NY5BG5m769eD
         fp2akNfNM1xg/suM2ybHQ+yiruTBLY/F5JpnI46GqP+v28KvxF65b7J0eFFVLODPsnny
         ZdLMa7cLNVV63o/WZJRMc7Ja2whs17OmeosRoVW0wkbSxSud8Sd28DGQHQn/YPOwR77i
         F7OxC9cCObXLRmAeoT0DMNHERcNowrzVyBpErUpyDSqqw1uWvNxBaZUaGf1AwxxFDtrH
         cQfYBYUT/PgWcgK7p5d71rj3DDRs4nJoOC8byugtvXiRs1xMcTXS97hP+yzxC+ijT5+d
         boqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789334213; x=1789939013; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cFkJlLROUmPxlY1gP0B5QhtPVhWh5/pBnHlPJP1GJfA=;
        b=RSW1kBeDJHwTrEulIfnXGEdv3SkSyv3tC+rhVv9QpLrt+60bFaMdEO4HQcsOkK08Ey
         WaOeYKIWre+v9Na2zvx2jWlNiNeLUL6pPj/1fViON+YdGUANW+eyZAFPsQn1BZhE6n1r
         kW8VqOs25o7F/FYinfCIel4u4AzdOv/JSPHP8TuGr5g5kEixHp3S31e1AA2ryAtjA14F
         EaykK8O+93Z30GxYbea8zDTFbhwFBiOxERFr3KpES06IKQSJ/PA2sNQzA9kshKl4SX/Z
         Atalk3mBB8m59HnCxBUVDuuPbSIsQ7l0FVGzUE23iD5NNIsPGlUaE+la9EEM3m7zULJa
         Qt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789334213; x=1789939013;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cFkJlLROUmPxlY1gP0B5QhtPVhWh5/pBnHlPJP1GJfA=;
        b=h1axfMuQRYcvWNfGG7auYC2qmoveD8JLm/pqy/pMBSsF9euxyZpRAiUQVvTbepm15o
         viWSkNr0hVTSPRv4nAGJdmSajD0D0LmcemgvKSx24VzYH9dR0/+PlHYG+F89/RsJUqH9
         hA4qc9rcvNLampzA6kIFoSIRpek4SsdfDnnjVvw6eGmqTUVI3Kg24VYxNHEeA192ZyzM
         8kYUx5yUcMnzoRkD2sOjzWhz7biIbpAjajKDpIXHs62iDUH2FUnDTbjlKZzDmEtdZ8s/
         8paK5kFdKT/W0vcJkoBMkcR+t0aBYsPNtLJ5TkYZLGTObiXeCADunYFlYqLh0L01PQ/q
         nSxw==
X-Forwarded-Encrypted: i=1; AKwUvBxGkCvwl6BFHobDb0o8zICR+ynC13q7UnDLuS5jj+oSuvWwLA48NR4p/GNCOfK7P+ZMkJ3havmvBdiILw==@vger.kernel.org
X-Gm-Message-State: AFuF++kuP4Q1ydTxviBX00WzcByBmcY58Uww8D0mc5l1YtbdCYMAa4Pb
	xuxMxjMvHh0D9E8Y6ZVYri3Y/Xv1aVIlgDWxCEAVPyectYC3WvtnSIOHq60R+jMrc7GH8WbJ+yv
	/Lzhzr9FD2FcuRmoSf7G8hMNtb+pxSPg=
X-Gm-Gg: AYBFou3PF9s6+p+w0q6vGaKPS6fnJTQf9toAYs7CzyC0u0hSde3AWu9qsDbyDPR2j31
	ugHFEf3+WOudAmh8LxiQv24L0C3nrGURgEjViqkRMuXOtFeow/2vSRDfFmXUFuyC7LZwmJNoyQf
	0cPyh/tpAL9tct00C93rMLwViIG5V/r78Mo2L6CIxy8xHe8lTvLuyTJtbVuR9kl4jD6hfaLNgL5
	4akoGuEuA+Ei1LXK25wl9K2F6nbC754fSHeCSOzzD/fcSJh7acyXdeX3fSndtWdlWNZk6irW+bR
	7wCYDcw46sRMIHCKaoHdEKCRW2y+zIlo6IGisFbgSXrBw7Gvd1H/oDBoTILgjzALGetASICJfSR
	fJjpdMgYASbtezzAVFEGquxkU
X-Received: by 2002:a05:620a:461e:b0:93a:26f:87cc with SMTP id
 af79cd13be357-93a18749f4dmr395271485a.24.1789334213480; Sun, 13 Sep 2026
 14:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEru=6LrMqg93AKrmbTJtvRNPx=arYuhSf4zMw4bK1SjWQQvrw@mail.gmail.com>
 <aoC-aI_7Dq_nJTHg@eggarch> <CAEru=6K=P_oJfksvRf2BfHZF9AFrQD4=izAwrSsz_Xit_i96xA@mail.gmail.com>
 <CAEru=6+Lnwn+UHcpGA29gcET=ERgiYCOqkR0ijShcfOFR1m-1g@mail.gmail.com>
 <CAEru=6K8gYwNWHFoYmwpQY8GGJ3HrqoJxKyu41nSSGQWOTVOdw@mail.gmail.com>
 <aoyO68JLUeCZbStK@eggarch> <CAEru=6JrUqo34ZtDES+VE3vbLGAFYd5UjnrpLOELKoEVg1Zx=A@mail.gmail.com>
 <CAEru=6+AJAJDw4uCi0=HFXH8XrOQhixHFk2e__o+hdd1m1ju5A@mail.gmail.com> <ap8JsxbZDmWxigZv@eggarch>
In-Reply-To: <ap8JsxbZDmWxigZv@eggarch>
From: Adam <testyiprywatnosc@gmail.com>
Date: Sun, 13 Sep 2026 23:16:41 +0200
X-Gm-Features: AcwNN1VDkCDYfFCQwlsceY6XT2tCqqFAlw_lhIvX0C3UVAaMydKJjn2e3YrNt5g
Message-ID: <CAEru=6+BjL4P1mwj_jib+QZgxTMUzrLEVBc4ez_rUnwtAbS9Ng@mail.gmail.com>
Subject: Re: [BUG] HID: i2c-hid: ELAN 04F3:30FD touchpad reset race causes
 -EREMOTEIO on HP Pavilion Gaming 15-ec1xxx
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: benjamin.tissoires@redhat.com, jikos@kernel.org, 
	linux-input@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000002e5545065b63d6fc"

--0000000000002e5545065b63d6fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the patch - tested it (kernel 7.2.4, patch applied cleanly
after manually reconciling two small context mismatches against my
tree - the descriptor/report reads now go through
i2c_hid_read_register_retry as intended).

I ran 6 boots with dyndbg enabled (3 warm/reboot, 3 cold/shutdown+
wait+power-on), collecting `dmesg | grep -iE "elan|i2c_hid"` after
each. Full logs attached (boot-logs-devpatch.txt, each boot labeled
warm/cold).

Summary: in all 6 boots, the pattern is the same - probe succeeds
quickly (HID descriptor fetch + registration within ~1-11s), but then
every subsequent get/set report call fails with -121 for the next
~10-30s, and none of these 6 logs showed a later recovery within the
capture window (I stopped capturing 15-30s after the last -121 in most
cases). Touchpad was not usable in any of these 6.

For context: right after building this kernel, on an earlier boot NOT
included in this batch, I saw a long stream of plausible-looking report
data (changing byte values consistent with coordinate movement)
starting around 72s after boot, following the same probe-then-errors
pattern. However, I want to be clear this was NOT a case of the
touchpad actually working - I was not able to move the cursor at that
time despite the kernel apparently receiving this data. I flagged this
same discrepancy in an earlier message in this thread (kernel-level
input events without perceived touchpad function) - I still don't have
an explanation for it, and don't want to overstate this as "recovery"
since functionally the touchpad was unusable in that case too.

So across all 7 boots I've tested with this patch so far (6 in this
batch + 1 earlier), touchpad was not usable in any of them.

Re: your Windows question - I tested this, and yes, the touchpad works
immediately after boot on Windows (tested a handful of boots, worked
every time).

Let me know if you'd like me to test with a longer wait/capture window
regardless (to see if the -121 errors eventually stop even without
real functionality), adjust the number of retries/delay in the patch,
or if the "input: events without working touchpad" discrepancy is
something you'd like me to investigate further (e.g. checking whether
libinput/evtest sees the same events, or capturing raw i2c traffic).

Thanks,
Adam


On Mon, Sep 7, 2026 at 10:50=E2=80=AFPM Lovekesh Solanki
<lovekeshsolanki00@gmail.com> wrote:
>
> On Sat, Sep 05, 2026 at 10:25:46AM +0200, Adam wrote:
> > One more finding, potentially significant: I found that holding/tapping
> > F9 at boot (HP's boot menu) repeatedly, or alternatively entering the
> > UEFI Firmware Settings from GRUB and immediately continuing boot, gives
> > the touchpad a reliable, working boot on my Ubuntu installation
> > (tested this handful of times, consistently works).
> Hmm.. I guess the f9 trick just moves probe's luck, nothing more.
>
> I wonder what would happen if we added a good amount of bounded
> retries on -EREMOTEIO and -EIO errors on the two reads
> [i2c_hid_fetch_hid_descriptor(), i2c_hid_parse()] retries are
> missing. I suppose firmware still responds to reads but NACKs any
> write during the 'unresponsive' window which lasts far longer than
> current retries can cover.
>
> Could you test a patch below with dyndbg enabled, on a mix of warm/cold
> boots, see if it improves this situation, if some boots still fail,
> include their probe timestamps.
>
> Also, on windows, does it start working immediatly after boot on all boot=
s?
>
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c=
-hid-core.c
> index 0ff07fdab442..b0e8e2cc24ff 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -241,6 +241,30 @@ static int i2c_hid_read_register(struct i2c_hid *ihi=
d, __le16 reg,
>         return i2c_hid_xfer(ihid, ihid->cmdbuf, sizeof(__le16), buf, len)=
;
>  }
>
> +#define I2C_HID_DESC_FETCH_TRIES 10
> +
> +static int i2c_hid_read_register_retry(struct i2c_hid *ihid, __le16 reg,=
 void *buf, size_t len) {
> +       int error;
> +       int i;
> +
> +       for(i =3D 0; i < I2C_HID_DESC_FETCH_TRIES; i++){
> +               if(i){
> +                       msleep(1000);
> +
> +                       if(i2c_hid_probe_address(ihid) < 0)
> +                               continue;
> +               }
> +
> +               error =3D i2c_hid_read_register(ihid, reg, buf, len);
> +               if(!error || (error !=3D -EREMOTEIO && error !=3D -EIO))
> +                       break;
> +
> +               i2c_hid_dbg(ihid, "register read failed (%d), retrying\n"=
, error);
> +       }
> +
> +       return error;
> +}
> +
>  static size_t i2c_hid_encode_command(u8 *buf, u8 opcode,
>                                      int report_type, int report_id)
>  {
> @@ -790,9 +814,7 @@ static int i2c_hid_parse(struct hid_device *hid)
>
>                 i2c_hid_dbg(ihid, "asking HID report descriptor\n");
>
> -               ret =3D i2c_hid_read_register(ihid,
> -                                           ihid->hdesc.wReportDescRegist=
er,
> -                                           rdesc, rsize);
> +               ret =3D i2c_hid_read_register_retry(ihid, ihid->hdesc.wRe=
portDescRegister, rdesc, rsize);
>                 if (ret) {
>                         dev_err(&client->dev, "reading report descriptor =
failed\n");
>                         goto out;
> @@ -909,10 +931,9 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_h=
id *ihid)
>                         *i2c_hid_get_dmi_i2c_hid_desc_override(client->na=
me);
>         } else {
>                 i2c_hid_dbg(ihid, "Fetching the HID descriptor\n");
> -               error =3D i2c_hid_read_register(ihid,
> -                                             ihid->wHIDDescRegister,
> -                                             &ihid->hdesc,
> -                                             sizeof(ihid->hdesc));
> +
> +               error =3D i2c_hid_read_register_retry(ihid, ihid->wHIDDes=
cRegister, &ihid->hdesc, sizeof(ihid->hdesc));
> +
>                 if (error) {
>                         dev_err(&ihid->client->dev,
>                                 "failed to fetch HID descriptor: %d\n",

--0000000000002e5545065b63d6fc
Content-Type: text/plain; charset="US-ASCII"; name="boot.txt"
Content-Disposition: attachment; filename="boot.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mu0bcsha0>
X-Attachment-Id: f_mu0bcsha0

d2FybQpbICAgIDEuNTYzNzUwXSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQg
dG8gcmVzZXQgZGV2aWNlOiAtMTIxClsgICAgMy43Mjc4ODddIGlucHV0OiBFTEFOMDcxODowMCAw
NEYzOjMwRkQgTW91c2UgYXMgL2RldmljZXMvcGxhdGZvcm0vQU1ESTAwMTA6MDMvaTJjLTAvaTJj
LUVMQU4wNzE4OjAwLzAwMTg6MDRGMzozMEZELjAwMDQvaW5wdXQvaW5wdXQ3ClsgICAgMy43Mjgz
NDhdIGlucHV0OiBFTEFOMDcxODowMCAwNEYzOjMwRkQgVG91Y2hwYWQgYXMgL2RldmljZXMvcGxh
dGZvcm0vQU1ESTAwMTA6MDMvaTJjLTAvaTJjLUVMQU4wNzE4OjAwLzAwMTg6MDRGMzozMEZELjAw
MDQvaW5wdXQvaW5wdXQ5ClsgICAgMy43Mjg1NjBdIGhpZC1nZW5lcmljIDAwMTg6MDRGMzozMEZE
LjAwMDQ6IGlucHV0LGhpZHJhdzM6IEkyQyBISUQgdjEuMDAgTW91c2UgW0VMQU4wNzE4OjAwIDA0
RjM6MzBGRF0gb24gaTJjLUVMQU4wNzE4OjAwClsgICAxMC4wNzE2OTVdIGkyY19oaWRfYWNwaSBp
MmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBnZXQgYSByZXBvcnQgZnJvbSBkZXZpY2U6IC0xMjEK
WyAgIDEwLjA3NTQ3Nl0gaTJjX2hpZF9hY3BpIGkyYy1FTEFOMDcxODowMDogZmFpbGVkIHRvIGdl
dCBhIHJlcG9ydCBmcm9tIGRldmljZTogLTEyMQpbICAgMTAuMDgyODA5XSBpbnB1dDogRUxBTjA3
MTg6MDAgMDRGMzozMEZEIE1vdXNlIGFzIC9kZXZpY2VzL3BsYXRmb3JtL0FNREkwMDEwOjAzL2ky
Yy0wL2kyYy1FTEFOMDcxODowMC8wMDE4OjA0RjM6MzBGRC4wMDA0L2lucHV0L2lucHV0MTIKWyAg
IDEwLjA4NDc0NV0gaW5wdXQ6IEVMQU4wNzE4OjAwIDA0RjM6MzBGRCBUb3VjaHBhZCBhcyAvZGV2
aWNlcy9wbGF0Zm9ybS9BTURJMDAxMDowMy9pMmMtMC9pMmMtRUxBTjA3MTg6MDAvMDAxODowNEYz
OjMwRkQuMDAwNC9pbnB1dC9pbnB1dDE0ClsgICAxMC4wODY2ODZdIGhpZC1tdWx0aXRvdWNoIDAw
MTg6MDRGMzozMEZELjAwMDQ6IGlucHV0LGhpZHJhdzM6IEkyQyBISUQgdjEuMDAgTW91c2UgW0VM
QU4wNzE4OjAwIDA0RjM6MzBGRF0gb24gaTJjLUVMQU4wNzE4OjAwClsgICAxMC4wODcwNDNdIGky
Y19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBzZXQgYSByZXBvcnQgdG8gZGV2
aWNlOiAtMTIxClsgICAxMC4wODg3NjVdIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZh
aWxlZCB0byBzZXQgYSByZXBvcnQgdG8gZGV2aWNlOiAtMTIxClsgICAxMC4yMjUzOTFdIGkyY19o
aWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBzZXQgYSByZXBvcnQgdG8gZGV2aWNl
OiAtMTIxClsgICAxMC4yMjYwODJdIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxl
ZCB0byBzZXQgYSByZXBvcnQgdG8gZGV2aWNlOiAtMTIxClsgICAxMC4yMzA4ODBdIGkyY19oaWRf
YWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBzZXQgYSByZXBvcnQgdG8gZGV2aWNlOiAt
MTIxClsgICAxMC4yMzEzMzhdIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0
byBzZXQgYSByZXBvcnQgdG8gZGV2aWNlOiAtMTIxClsgICAxMC4yNjIxMjFdIGkyY19oaWRfYWNw
aSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBzZXQgYSByZXBvcnQgdG8gZGV2aWNlOiAtMTIx
ClsgICAxMC4zMDYzOTFdIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBz
ZXQgYSByZXBvcnQgdG8gZGV2aWNlOiAtMTIxClsgICAxMC4zMzE0NTZdIGkyY19oaWRfYWNwaSBp
MmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBzZXQgYSByZXBvcnQgdG8gZGV2aWNlOiAtMTIxClsg
ICAxMC4zNDIwOTJdIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBzZXQg
YSByZXBvcnQgdG8gZGV2aWNlOiAtMTIxClsgICAxMC4zNDMwMzhdIGkyY19oaWRfYWNwaSBpMmMt
RUxBTjA3MTg6MDA6IGZhaWxlZCB0byBzZXQgYSByZXBvcnQgdG8gZGV2aWNlOiAtMTIxClsgICAx
MC4zNTEyOThdIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBzZXQgYSBy
ZXBvcnQgdG8gZGV2aWNlOiAtMTIxClsgICAxMy45OTI1NDhdIGkyY19oaWRfYWNwaSBpMmMtRUxB
TjA3MTg6MDA6IGZhaWxlZCB0byBzZXQgYSByZXBvcnQgdG8gZGV2aWNlOiAtMTIxClsgICAyMS42
NTE1MDhdIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBzZXQgYSByZXBv
cnQgdG8gZGV2aWNlOiAtMTIxClsgICAyMS42NTE2MDZdIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3
MTg6MDA6IGZhaWxlZCB0byBzZXQgYSByZXBvcnQgdG8gZGV2aWNlOiAtMTIxCgpjb2xkClsgICAg
MS43MzA3MzFdIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBjaGFuZ2Ug
cG93ZXIgc2V0dGluZy4KWyAgICAyLjc1NDM5NV0gaTJjX2hpZF9hY3BpIGkyYy1FTEFOMDcxODow
MDogZmFpbGVkIHRvIGNoYW5nZSBwb3dlciBzZXR0aW5nLgpbICAgIDYuOTI3NzMyXSBpbnB1dDog
RUxBTjA3MTg6MDAgMDRGMzozMEZEIE1vdXNlIGFzIC9kZXZpY2VzL3BsYXRmb3JtL0FNREkwMDEw
OjAzL2kyYy0wL2kyYy1FTEFOMDcxODowMC8wMDE4OjA0RjM6MzBGRC4wMDA0L2lucHV0L2lucHV0
NwpbICAgIDYuOTI4MDE4XSBpbnB1dDogRUxBTjA3MTg6MDAgMDRGMzozMEZEIFRvdWNocGFkIGFz
IC9kZXZpY2VzL3BsYXRmb3JtL0FNREkwMDEwOjAzL2kyYy0wL2kyYy1FTEFOMDcxODowMC8wMDE4
OjA0RjM6MzBGRC4wMDA0L2lucHV0L2lucHV0OQpbICAgIDYuOTI4Mjg2XSBoaWQtZ2VuZXJpYyAw
MDE4OjA0RjM6MzBGRC4wMDA0OiBpbnB1dCxoaWRyYXczOiBJMkMgSElEIHYxLjAwIE1vdXNlIFtF
TEFOMDcxODowMCAwNEYzOjMwRkRdIG9uIGkyYy1FTEFOMDcxODowMApbICAgMTMuMjkzMTMyXSBp
MmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gZ2V0IGEgcmVwb3J0IGZyb20g
ZGV2aWNlOiAtMTIxClsgICAxMy4yOTQxMDFdIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6
IGRldmljZSByZXR1cm5lZCBpbmNvcnJlY3QgcmVwb3J0ICgwIHZzIDIgZXhwZWN0ZWQpClsgICAx
My4yOTQ3MTJdIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBnZXQgYSBy
ZXBvcnQgZnJvbSBkZXZpY2U6IC0xMjEKWyAgIDEzLjMwNzY3N10gaW5wdXQ6IEVMQU4wNzE4OjAw
IDA0RjM6MzBGRCBNb3VzZSBhcyAvZGV2aWNlcy9wbGF0Zm9ybS9BTURJMDAxMDowMy9pMmMtMC9p
MmMtRUxBTjA3MTg6MDAvMDAxODowNEYzOjMwRkQuMDAwNC9pbnB1dC9pbnB1dDEzClsgICAxMy4z
MDk1MTBdIGlucHV0OiBFTEFOMDcxODowMCAwNEYzOjMwRkQgVG91Y2hwYWQgYXMgL2RldmljZXMv
cGxhdGZvcm0vQU1ESTAwMTA6MDMvaTJjLTAvaTJjLUVMQU4wNzE4OjAwLzAwMTg6MDRGMzozMEZE
LjAwMDQvaW5wdXQvaW5wdXQxNQpbICAgMTMuMzA5ODIzXSBoaWQtbXVsdGl0b3VjaCAwMDE4OjA0
RjM6MzBGRC4wMDA0OiBpbnB1dCxoaWRyYXczOiBJMkMgSElEIHYxLjAwIE1vdXNlIFtFTEFOMDcx
ODowMCAwNEYzOjMwRkRdIG9uIGkyYy1FTEFOMDcxODowMApbICAgMTMuMzA5OTEzXSBpMmNfaGlk
X2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRldmljZTog
LTEyMQpbICAgMTMuMzEwNDc3XSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQg
dG8gc2V0IGEgcmVwb3J0IHRvIGRldmljZTogLTEyMQpbICAgMTMuNTA2NTk1XSBpMmNfaGlkX2Fj
cGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRldmljZTogLTEy
MQpbICAgMTMuNTQ1MjU4XSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8g
c2V0IGEgcmVwb3J0IHRvIGRldmljZTogLTEyMQpbICAgMTMuNTczNDY4XSBpMmNfaGlkX2FjcGkg
aTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRldmljZTogLTEyMQpb
ICAgMTMuNTc0MjQ3XSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0
IGEgcmVwb3J0IHRvIGRldmljZTogLTEyMQpbICAgMTMuNTg0MDE5XSBpMmNfaGlkX2FjcGkgaTJj
LUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRldmljZTogLTEyMQpbICAg
MTMuNTg0NzU5XSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0IGEg
cmVwb3J0IHRvIGRldmljZTogLTEyMQpbICAgMTMuNTkyNjYyXSBpMmNfaGlkX2FjcGkgaTJjLUVM
QU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRldmljZTogLTEyMQpbICAgMTMu
NTkzMTExXSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0IGEgcmVw
b3J0IHRvIGRldmljZTogLTEyMQpbICAgMTcuMDAxNDkzXSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4w
NzE4OjAwOiBmYWlsZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRldmljZTogLTEyMQpbICAgMzguODcx
NTMxXSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0IGEgcmVwb3J0
IHRvIGRldmljZTogLTEyMQoKY29sZApbICAgIDUuODg4Njk5XSBpMmNfaGlkX2FjcGkgaTJjLUVM
QU4wNzE4OjAwOiBmYWlsZWQgdG8gcmVzZXQgZGV2aWNlOiAtMTIxClsgICAgNS44ODg4NzhdIGky
Y19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBjaGFuZ2UgcG93ZXIgc2V0dGlu
Zy4KWyAgIDEwLjA2Mzg1Ml0gaW5wdXQ6IEVMQU4wNzE4OjAwIDA0RjM6MzBGRCBNb3VzZSBhcyAv
ZGV2aWNlcy9wbGF0Zm9ybS9BTURJMDAxMDowMy9pMmMtMC9pMmMtRUxBTjA3MTg6MDAvMDAxODow
NEYzOjMwRkQuMDAwNC9pbnB1dC9pbnB1dDcKWyAgIDEwLjA2NDE1N10gaW5wdXQ6IEVMQU4wNzE4
OjAwIDA0RjM6MzBGRCBUb3VjaHBhZCBhcyAvZGV2aWNlcy9wbGF0Zm9ybS9BTURJMDAxMDowMy9p
MmMtMC9pMmMtRUxBTjA3MTg6MDAvMDAxODowNEYzOjMwRkQuMDAwNC9pbnB1dC9pbnB1dDkKWyAg
IDEwLjA2NDQwN10gaGlkLWdlbmVyaWMgMDAxODowNEYzOjMwRkQuMDAwNDogaW5wdXQsaGlkcmF3
MzogSTJDIEhJRCB2MS4wMCBNb3VzZSBbRUxBTjA3MTg6MDAgMDRGMzozMEZEXSBvbiBpMmMtRUxB
TjA3MTg6MDAKWyAgIDE2LjYzNTc3Nl0gaTJjX2hpZF9hY3BpIGkyYy1FTEFOMDcxODowMDogZmFp
bGVkIHRvIGdldCBhIHJlcG9ydCBmcm9tIGRldmljZTogLTEyMQpbICAgMTYuNjM2NDY1XSBpbnB1
dDogRUxBTjA3MTg6MDAgMDRGMzozMEZEIE1vdXNlIGFzIC9kZXZpY2VzL3BsYXRmb3JtL0FNREkw
MDEwOjAzL2kyYy0wL2kyYy1FTEFOMDcxODowMC8wMDE4OjA0RjM6MzBGRC4wMDA0L2lucHV0L2lu
cHV0MTIKWyAgIDE2LjY0NzQ2OV0gaW5wdXQ6IEVMQU4wNzE4OjAwIDA0RjM6MzBGRCBUb3VjaHBh
ZCBhcyAvZGV2aWNlcy9wbGF0Zm9ybS9BTURJMDAxMDowMy9pMmMtMC9pMmMtRUxBTjA3MTg6MDAv
MDAxODowNEYzOjMwRkQuMDAwNC9pbnB1dC9pbnB1dDE0ClsgICAxNi42NTM4NDhdIGhpZC1tdWx0
aXRvdWNoIDAwMTg6MDRGMzozMEZELjAwMDQ6IGlucHV0LGhpZHJhdzM6IEkyQyBISUQgdjEuMDAg
TW91c2UgW0VMQU4wNzE4OjAwIDA0RjM6MzBGRF0gb24gaTJjLUVMQU4wNzE4OjAwClsgICAxNi43
Mjg1MTRdIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBzZXQgYSByZXBv
cnQgdG8gZGV2aWNlOiAtMTIxClsgICAxNi43Mjk0ODddIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3
MTg6MDA6IGZhaWxlZCB0byBzZXQgYSByZXBvcnQgdG8gZGV2aWNlOiAtMTIxClsgICAxNi43NDY0
NzldIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBzZXQgYSByZXBvcnQg
dG8gZGV2aWNlOiAtMTIxClsgICAxNi43NDc4ODZdIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6
MDA6IGZhaWxlZCB0byBzZXQgYSByZXBvcnQgdG8gZGV2aWNlOiAtMTIxClsgICAxNi43ODIwOTFd
IGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBzZXQgYSByZXBvcnQgdG8g
ZGV2aWNlOiAtMTIxClsgICAxNi43ODI2MTJdIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6
IGZhaWxlZCB0byBzZXQgYSByZXBvcnQgdG8gZGV2aWNlOiAtMTIxClsgICAxNi43OTM4MzddIGky
Y19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBzZXQgYSByZXBvcnQgdG8gZGV2
aWNlOiAtMTIxClsgICAxNi44MjkxMjldIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZh
aWxlZCB0byBzZXQgYSByZXBvcnQgdG8gZGV2aWNlOiAtMTIxClsgICAxNi44Mzc4ODZdIGkyY19o
aWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBzZXQgYSByZXBvcnQgdG8gZGV2aWNl
OiAtMTIxClsgICAxNi44Mzc5NTVdIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxl
ZCB0byBzZXQgYSByZXBvcnQgdG8gZGV2aWNlOiAtMTIxClsgICAxNi44NDkzNzZdIGkyY19oaWRf
YWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBzZXQgYSByZXBvcnQgdG8gZGV2aWNlOiAt
MTIxClsgICAxNi44OTE0NTldIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0
byBzZXQgYSByZXBvcnQgdG8gZGV2aWNlOiAtMTIxClsgICAxNi44OTI0MzJdIGkyY19oaWRfYWNw
aSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBzZXQgYSByZXBvcnQgdG8gZGV2aWNlOiAtMTIx
ClsgICAyNC4yNDQ1MjFdIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBz
ZXQgYSByZXBvcnQgdG8gZGV2aWNlOiAtMTIxClsgICAyNC4yNDUwNzBdIGkyY19oaWRfYWNwaSBp
MmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBzZXQgYSByZXBvcnQgdG8gZGV2aWNlOiAtMTIxCgp3
YXJtClsgICAgMi43NTY5MTVdIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0
byBjaGFuZ2UgcG93ZXIgc2V0dGluZy4KWyAgICAzLjg1NTMyN10gaW5wdXQ6IEVMQU4wNzE4OjAw
IDA0RjM6MzBGRCBNb3VzZSBhcyAvZGV2aWNlcy9wbGF0Zm9ybS9BTURJMDAxMDowMy9pMmMtMC9p
MmMtRUxBTjA3MTg6MDAvMDAxODowNEYzOjMwRkQuMDAwNC9pbnB1dC9pbnB1dDcKWyAgICAzLjg1
NTczMl0gaW5wdXQ6IEVMQU4wNzE4OjAwIDA0RjM6MzBGRCBUb3VjaHBhZCBhcyAvZGV2aWNlcy9w
bGF0Zm9ybS9BTURJMDAxMDowMy9pMmMtMC9pMmMtRUxBTjA3MTg6MDAvMDAxODowNEYzOjMwRkQu
MDAwNC9pbnB1dC9pbnB1dDkKWyAgICAzLjg1NTkyOF0gaGlkLWdlbmVyaWMgMDAxODowNEYzOjMw
RkQuMDAwNDogaW5wdXQsaGlkcmF3MzogSTJDIEhJRCB2MS4wMCBNb3VzZSBbRUxBTjA3MTg6MDAg
MDRGMzozMEZEXSBvbiBpMmMtRUxBTjA3MTg6MDAKWyAgIDEwLjQ3ODgzOV0gaTJjX2hpZF9hY3Bp
IGkyYy1FTEFOMDcxODowMDogZmFpbGVkIHRvIGdldCBhIHJlcG9ydCBmcm9tIGRldmljZTogLTEy
MQpbICAgMTAuNDc5Njc0XSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8g
Z2V0IGEgcmVwb3J0IGZyb20gZGV2aWNlOiAtMTIxClsgICAxMC40ODA5ODFdIGkyY19oaWRfYWNw
aSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBnZXQgYSByZXBvcnQgZnJvbSBkZXZpY2U6IC0x
MjEKWyAgIDEwLjQ4MTU0Ml0gaW5wdXQ6IEVMQU4wNzE4OjAwIDA0RjM6MzBGRCBNb3VzZSBhcyAv
ZGV2aWNlcy9wbGF0Zm9ybS9BTURJMDAxMDowMy9pMmMtMC9pMmMtRUxBTjA3MTg6MDAvMDAxODow
NEYzOjMwRkQuMDAwNC9pbnB1dC9pbnB1dDEyClsgICAxMC40ODE2NzVdIGlucHV0OiBFTEFOMDcx
ODowMCAwNEYzOjMwRkQgVG91Y2hwYWQgYXMgL2RldmljZXMvcGxhdGZvcm0vQU1ESTAwMTA6MDMv
aTJjLTAvaTJjLUVMQU4wNzE4OjAwLzAwMTg6MDRGMzozMEZELjAwMDQvaW5wdXQvaW5wdXQxNApb
ICAgMTAuNDgyNTcwXSBoaWQtbXVsdGl0b3VjaCAwMDE4OjA0RjM6MzBGRC4wMDA0OiBpbnB1dCxo
aWRyYXczOiBJMkMgSElEIHYxLjAwIE1vdXNlIFtFTEFOMDcxODowMCAwNEYzOjMwRkRdIG9uIGky
Yy1FTEFOMDcxODowMApbICAgMTAuNDgzNDk1XSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAw
OiBmYWlsZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRldmljZTogLTEyMQpbICAgMTAuNTI5MjUwXSBp
MmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRl
dmljZTogLTEyMQpbICAgMTAuNTQyMTA1XSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBm
YWlsZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRldmljZTogLTEyMQpbICAgMTAuNjIzMjI2XSBpMmNf
aGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRldmlj
ZTogLTEyMQpbICAgMTAuNjIzOTEzXSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWls
ZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRldmljZTogLTEyMQpbICAgMTAuNjM4MDY2XSBpMmNfaGlk
X2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRldmljZTog
LTEyMQpbICAgMTAuNjU3MTY0XSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQg
dG8gc2V0IGEgcmVwb3J0IHRvIGRldmljZTogLTEyMQpbICAgMTAuNjU3OTcwXSBpMmNfaGlkX2Fj
cGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRldmljZTogLTEy
MQpbICAgMTAuNjY2ODg1XSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8g
c2V0IGEgcmVwb3J0IHRvIGRldmljZTogLTEyMQpbICAgMTAuNjg5ODI2XSBpMmNfaGlkX2FjcGkg
aTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRldmljZTogLTEyMQpb
ICAgMTAuNjk4NDUwXSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0
IGEgcmVwb3J0IHRvIGRldmljZTogLTEyMQpbICAgMTMuOTEzNjg0XSBpMmNfaGlkX2FjcGkgaTJj
LUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRldmljZTogLTEyMQpbICAg
MjQuNjMyOTI0XSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0IGEg
cmVwb3J0IHRvIGRldmljZTogLTEyMQoKd2FybQpbICAgIDQuODc5OTcyXSBpbnB1dDogRUxBTjA3
MTg6MDAgMDRGMzozMEZEIE1vdXNlIGFzIC9kZXZpY2VzL3BsYXRmb3JtL0FNREkwMDEwOjAzL2ky
Yy0wL2kyYy1FTEFOMDcxODowMC8wMDE4OjA0RjM6MzBGRC4wMDA0L2lucHV0L2lucHV0NwpbICAg
IDQuODgwMTA0XSBpbnB1dDogRUxBTjA3MTg6MDAgMDRGMzozMEZEIFRvdWNocGFkIGFzIC9kZXZp
Y2VzL3BsYXRmb3JtL0FNREkwMDEwOjAzL2kyYy0wL2kyYy1FTEFOMDcxODowMC8wMDE4OjA0RjM6
MzBGRC4wMDA0L2lucHV0L2lucHV0OQpbICAgIDQuODgwMjMwXSBoaWQtZ2VuZXJpYyAwMDE4OjA0
RjM6MzBGRC4wMDA0OiBpbnB1dCxoaWRyYXczOiBJMkMgSElEIHYxLjAwIE1vdXNlIFtFTEFOMDcx
ODowMCAwNEYzOjMwRkRdIG9uIGkyYy1FTEFOMDcxODowMApbICAgMTEuNTg3MDk1XSBpMmNfaGlk
X2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gZ2V0IGEgcmVwb3J0IGZyb20gZGV2aWNl
OiAtMTIxClsgICAxMS41ODgyMzVdIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxl
ZCB0byBnZXQgYSByZXBvcnQgZnJvbSBkZXZpY2U6IC0xMjEKWyAgIDExLjU5MzAxMl0gaW5wdXQ6
IEVMQU4wNzE4OjAwIDA0RjM6MzBGRCBNb3VzZSBhcyAvZGV2aWNlcy9wbGF0Zm9ybS9BTURJMDAx
MDowMy9pMmMtMC9pMmMtRUxBTjA3MTg6MDAvMDAxODowNEYzOjMwRkQuMDAwNC9pbnB1dC9pbnB1
dDEyClsgICAxMS42MDE0ODRdIGlucHV0OiBFTEFOMDcxODowMCAwNEYzOjMwRkQgVG91Y2hwYWQg
YXMgL2RldmljZXMvcGxhdGZvcm0vQU1ESTAwMTA6MDMvaTJjLTAvaTJjLUVMQU4wNzE4OjAwLzAw
MTg6MDRGMzozMEZELjAwMDQvaW5wdXQvaW5wdXQxNApbICAgMTEuNjA0NzA1XSBoaWQtbXVsdGl0
b3VjaCAwMDE4OjA0RjM6MzBGRC4wMDA0OiBpbnB1dCxoaWRyYXczOiBJMkMgSElEIHYxLjAwIE1v
dXNlIFtFTEFOMDcxODowMCAwNEYzOjMwRkRdIG9uIGkyYy1FTEFOMDcxODowMApbICAgMTEuNjgz
NzI3XSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0IGEgcmVwb3J0
IHRvIGRldmljZTogLTEyMQpbICAgMTEuNjk4OTkyXSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4
OjAwOiBmYWlsZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRldmljZTogLTEyMQpbICAgMTEuNzAwNDQw
XSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0IGEgcmVwb3J0IHRv
IGRldmljZTogLTEyMQpbICAgMTEuNzQ3NDMxXSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAw
OiBmYWlsZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRldmljZTogLTEyMQpbICAgMTEuNzQ4NzY5XSBp
MmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRl
dmljZTogLTEyMQpbICAgMTEuODE3MjM4XSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBm
YWlsZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRldmljZTogLTEyMQpbICAgMTEuODI3ODkxXSBpMmNf
aGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRldmlj
ZTogLTEyMQpbICAgMTEuODM5MDM0XSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWls
ZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRldmljZTogLTEyMQpbICAgMTEuODQ2MzAzXSBpMmNfaGlk
X2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gc2V0IGEgcmVwb3J0IHRvIGRldmljZTog
LTEyMQpbICAgMTUuNDA5NDM0XSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQg
dG8gc2V0IGEgcmVwb3J0IHRvIGRldmljZTogLTEyMQpbICAgMjIuMjg5NDM2XSBpMmNfaGlkX2Fj
cGkgaTJjLUVMQQoKY29sZApbICAgIDQuODgwODAwXSBpbnB1dDogRUxBTjA3MTg6MDAgMDRGMzoz
MEZEIE1vdXNlIGFzIC9kZXZpY2VzL3BsYXRmb3JtL0FNREkwMDEwOjAzL2kyYy0wL2kyYy1FTEFO
MDcxODowMC8wMDE4OjA0RjM6MzBGRC4wMDA0L2lucHV0L2lucHV0NwpbICAgIDQuODgxMTA5XSBp
bnB1dDogRUxBTjA3MTg6MDAgMDRGMzozMEZEIFRvdWNocGFkIGFzIC9kZXZpY2VzL3BsYXRmb3Jt
L0FNREkwMDEwOjAzL2kyYy0wL2kyYy1FTEFOMDcxODowMC8wMDE4OjA0RjM6MzBGRC4wMDA0L2lu
cHV0L2lucHV0OQpbICAgIDQuODgxNDEyXSBoaWQtZ2VuZXJpYyAwMDE4OjA0RjM6MzBGRC4wMDA0
OiBpbnB1dCxoaWRyYXczOiBJMkMgSElEIHYxLjAwIE1vdXNlIFtFTEFOMDcxODowMCAwNEYzOjMw
RkRdIG9uIGkyYy1FTEFOMDcxODowMApbICAgMTEuMjMwMzM1XSBpMmNfaGlkX2FjcGkgaTJjLUVM
QU4wNzE4OjAwOiBmYWlsZWQgdG8gZ2V0IGEgcmVwb3J0IGZyb20gZGV2aWNlOiAtMTIxClsgICAx
MS4yMzEwNThdIGkyY19oaWRfYWNwaSBpMmMtRUxBTjA3MTg6MDA6IGZhaWxlZCB0byBnZXQgYSBy
ZXBvcnQgZnJvbSBkZXZpY2U6IC0xMjEKWyAgIDExLjIzMjA1MV0gaTJjX2hpZF9hY3BpIGkyYy1F
TEFOMDcxODowMDogZmFpbGVkIHRvIGdldCBhIHJlcG9ydCBmcm9tIGRldmljZTogLTEyMQpbICAg
MTEuMjMyOTU0XSBpMmNfaGlkX2FjcGkgaTJjLUVMQU4wNzE4OjAwOiBmYWlsZWQgdG8gZ2V0IGEg
cmVwb3J0IGZyb20gZGV2aWNlOiAtMTIxClsgICAxMS4yMzc3MzBdIGlucHV0OiBFTEFOMDcxODow
MCAwNEYzOjMwRkQgTW91c2UgYXMgL2RldmljZXMvcGxhdGZvcm0vQU1ESTAwMTA6MDMvaTJjLTAv
aTJjLUVMQU4wNzE4OjAwLzAwMTg6MDRGMzozMEZELjAwMDQvaW5wdXQvaW5wdXQxMQpbICAgMTEu
MjQyNjg3XSBpbnB1dDogRUxBTjA3MTg6MDAgMDRGMzozMEZEIFRvdWNocGFkIGFzIC9kZXZpY2Vz
L3BsYXRmb3JtL0FNREkwMDEwOjAzL2kyYy0wL2kyYy1FTEFOMDcxODowMC8wMDE4OjA0RjM6MzBG
RC4wMDA0L2lucHV0L2lucHV0MTMKWyAgIDExLjI0NDQ5MV0gaGlkLW11bHRpdG91Y2ggMDAxODow
NEYzOjMwRkQuMDAwNDogaW5wdXQsaGlkcmF3MzogSTJDIEhJRCB2MS4wMCBNb3VzZSBbRUxBTjA3
MTg6MDAgMDRGMzozMEZEXSBvbiBpMmMtRUxBTjA3MTg6MDAKWyAgIDExLjI0NDgxN10gaTJjX2hp
ZF9hY3BpIGkyYy1FTEFOMDcxODowMDogZmFpbGVkIHRvIHNldCBhIHJlcG9ydCB0byBkZXZpY2U6
IC0xMjEKWyAgIDExLjI0NTI3N10gaTJjX2hpZF9hY3BpIGkyYy1FTEFOMDcxODowMDogZmFpbGVk
IHRvIHNldCBhIHJlcG9ydCB0byBkZXZpY2U6IC0xMjEKWyAgIDExLjI5NzcyN10gaTJjX2hpZF9h
Y3BpIGkyYy1FTEFOMDcxODowMDogZmFpbGVkIHRvIHNldCBhIHJlcG9ydCB0byBkZXZpY2U6IC0x
MjEKWyAgIDExLjMwOTEwOV0gaTJjX2hpZF9hY3BpIGkyYy1FTEFOMDcxODowMDogZmFpbGVkIHRv
IHNldCBhIHJlcG9ydCB0byBkZXZpY2U6IC0xMjEKWyAgIDExLjM2NjIxOV0gaTJjX2hpZF9hY3Bp
IGkyYy1FTEFOMDcxODowMDogZmFpbGVkIHRvIHNldCBhIHJlcG9ydCB0byBkZXZpY2U6IC0xMjEK
WyAgIDExLjM2Nzg0N10gaTJjX2hpZF9hY3BpIGkyYy1FTEFOMDcxODowMDogZmFpbGVkIHRvIHNl
dCBhIHJlcG9ydCB0byBkZXZpY2U6IC0xMjEKWyAgIDExLjM5NTcwNV0gaTJjX2hpZF9hY3BpIGky
Yy1FTEFOMDcxODowMDogZmFpbGVkIHRvIHNldCBhIHJlcG9ydCB0byBkZXZpY2U6IC0xMjEKWyAg
IDExLjQwNzQxOF0gaTJjX2hpZF9hY3BpIGkyYy1FTEFOMDcxODowMDogZmFpbGVkIHRvIHNldCBh
IHJlcG9ydCB0byBkZXZpY2U6IC0xMjEKWyAgIDExLjQwODE4NF0gaTJjX2hpZF9hY3BpIGkyYy1F
TEFOMDcxODowMDogZmFpbGVkIHRvIHNldCBhIHJlcG9ydCB0byBkZXZpY2U6IC0xMjEKWyAgIDEx
LjQyNjI1MF0gaTJjX2hpZF9hY3BpIGkyYy1FTEFOMDcxODowMDogZmFpbGVkIHRvIHNldCBhIHJl
cG9ydCB0byBkZXZpY2U6IC0xMjEKWyAgIDExLjQyNjk2Nl0gaTJjX2hpZF9hY3BpIGkyYy1FTEFO
MDcxODowMDogZmFpbGVkIHRvIHNldCBhIHJlcG9ydCB0byBkZXZpY2U6IC0xMjEKWyAgIDExLjQy
NzYwNV0gaTJjX2hpZF9hY3BpIGkyYy1FTEFOMDcxODowMDogZmFpbGVkIHRvIHNldCBhIHJlcG9y
dCB0byBkZXZpY2U6IC0xMjEKWyAgIDExLjQ2MzkyNl0gaTJjX2hpZF9hY3BpIGkyYy1FTEFOMDcx
ODowMDogZmFpbGVkIHRvIHNldCBhIHJlcG9ydCB0byBkZXZpY2U6IC0xMjEKWyAgIDE1LjA1MTYx
MV0gaTJjX2hpZF9hY3BpIGkyYy1FTEFOMDcxODowMDogZmFpbGVkIHRvIHNldCBhIHJlcG9ydCB0
byBkZXZpY2U6IC0xMjEKWyAgIDE5LjA1OTE1NV0gaTJjX2hpZF9hY3BpIGkyYy1FTEFOMDcxODow
MDogZmFpbGVkIHRvIHNldCBhIHJlcG9ydCB0byBkZXZpY2U6IC0xMjEKWyAgIDE5LjU3NjA1NV0g
aTJjX2hpZF9hY3BpIGkyYy1FTEFOMDcxODowMDogZmFpbGVkIHRvIHNldCBhIHJlcG9ydCB0byBk
ZXZpY2U6IC0xMjEK
--0000000000002e5545065b63d6fc--
