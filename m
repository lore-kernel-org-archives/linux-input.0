Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B875478D
	for <linux-input@vger.kernel.org>; Sun,  2 Aug 2026 00:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785630113; cv=none; b=DJA/kL8cMvSnlr9XlRwZI0/AaGz7Z06mFb4JSe6WuuO0hoWmEjNehhk99kuYkFS7HgDDFeCfXYmULQQe2IMTq5NlXAL67yDzt28kdjUrfgMf3D53mp6VHtyNweiE1mlwKYVRE4VJ8EmPUXqILnYGwA98GjQcqUseK49renD5Lj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785630113; c=relaxed/simple;
	bh=Pfju/2NzE2Ng8eRYMrOrZIQwYU3DAeB9JlGcSnZi4H4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=i6ftzkw9d13wd5xHoTusphLqKyWYE2MA2MGYbrpn7g9zA97cMHoDC+oasrO3I2Akms5Mspnf482SU0iLlO6Wr/kMrRmf5UNNRavysgNq1FZ/GE3fi3IvrcQ+wyK6dQqZLzidpT8imPHTl2VXlgfIxfaFzDInyblWR1Z7dua19kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=HliSQL3B; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=aROD6hF0; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="HliSQL3B";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="aROD6hF0"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=HliSQL3BADRPbq74D8dX6zdJxDs0HHopXBCIWzNxwzIl7TduyrVepoafzs0ax0QziHeeYoPsJVLyGXWrCP5SO2g2egbxb+bqD9pRyBzXas0poVUc3uNmWz599b7qAo33m9exSDn6NdR/qUXarJZCFL4JaYsFXZdIBiTlogUMuh94nD2T7Jk6zFo/qn/WZT5vtGSjluBaXoiZTx1z4p7HGNISflTqFTv/vH83SZ+uGYtY6DfPlUJbACIixw2E/ow6Pp2TMHl6YwaVKmFNhU966Qx2LeXezOH45ESWRib1Ro0cyRRkavpRB3dFHH85Ccb9LdFU0l6FfGxkHTSQHladWQ==; s=purelymail1; d=rcpassos.me; v=1; bh=Pfju/2NzE2Ng8eRYMrOrZIQwYU3DAeB9JlGcSnZi4H4=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=aROD6hF0dabNtm7huRvcFIa7IlMOC/O4FVviK8FWJn6KIE5WleHTg/yGGlPpgmlL2ousQmS5x6gPNDNfzOmxlG4gwgdNMOSXjkftX0mpqVrKWdyylj1CW4fFL7JPqJvQz0E9052ExZhJc2/ehF6MVWh32xs4mQN/szB1xK+ii5Cg6ovCKj/MBjRkDH6LJmPtYbhP69+y3PqrXrdfHGK/GY8VQwJ756a18zFKGc60uFSY/4fptToc6Zs8FYfk1Eu2j6bbbPI923dsl9TY3JjbD+6lexpmBVW+HJTRU7I5yHg7LSYC9QO/DSBtRK+orqFmVmYQUSZMFhAEOwYQR4TIgQ==; s=purelymail1; d=purelymail.com; v=1; bh=Pfju/2NzE2Ng8eRYMrOrZIQwYU3DAeB9JlGcSnZi4H4=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1750192128;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 02 Aug 2026 00:21:33 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 21:21:32 -0300
Message-Id: <DKE11FVZYDCW.1UEUU1GSXHP3B@rcpassos.me>
Subject: Re: [PATCH v3 1/4] HID: wiimote: turn on the LEDs indicating the
 controller id
Cc: "Shuah Khan" <skhan@linuxfoundation.org>, "Brigham Campbell"
 <me@brighamcampbell.com>, "Jori Koolstra" <jkoolstra@xs4all.nl>,
 <linux-input@vger.kernel.org>
From: "Rafael Passos" <rafael@rcpassos.me>
To: "David Rheinsberg" <david@readahead.eu>, "Rafael Passos"
 <rafael@rcpassos.me>, "Jiri Kosina" <jikos@kernel.org>, "Benjamin
 Tissoires" <bentiss@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260729164928.1138468-1-rafael@rcpassos.me>
 <20260729164928.1138468-2-rafael@rcpassos.me>
 <6ffe2879-5d76-42b3-bd65-2180967d1498@app.fastmail.com>
In-Reply-To: <6ffe2879-5d76-42b3-bd65-2180967d1498@app.fastmail.com>

On Fri Jul 31, 2026 at 6:02 AM -03, David Rheinsberg wrote:
>> -	hid_info(hdev, "New device registered\n");
>> +	player_id =3D ida_alloc_min(&wiimote_ida, 1, GFP_KERNEL);
>> +	if (player_id < 1) {
>> +		hid_err(hdev, "cannot allocate controller id\n");
>> +		ret =3D player_id;
>> +		goto err_free;
>> +	}
>> +
>> +	wdata->player_id =3D player_id;
>> +
>> +	hid_info(hdev, "New device registered (Wiimote %d)\n", player_id);
>
> `wiimote_create()` should initialize `wdata->player_id` to -1, so `ida_fr=
ee()` is a no-op in the `err_free` path. Right now it is implicitly initial=
ized to 0, and thus ida_free() will warn about an unallocated ID.
>
> Also: Why not just use IDs starting from 0?

I chose to start from 1 to avoid "id 0 =3D player 1".

Wouldn't setting an u8 to -1 result into 255 ? If so,
this would not be a no-op. Also, comparing player_id < 0 would never be
true. If the IDA starts from 0, there is no usable "empty value" in a u8
when deciding if I should call ida_free.
If I let "failure" to be 0, I can just use this in destroy:

if (wdata->player_id)
	ida_free(&wiimote_ida, wdata->player_id);


Thanks,
Rafael
