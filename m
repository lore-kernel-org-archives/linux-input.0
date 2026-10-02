Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7C04D37A9
	for <linux-input@vger.kernel.org>; Fri,  2 Oct 2026 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790954461; cv=pass; b=GWCuXJnQlJ7k/Q60ojGovYpoveIl2VGv509M79xu5AuK0jFpt3SQ3xvrLIoI374WVRwWBfZ+JsYk1CrlKVs7zkQ4VE6fqtB+z8EghBsQqMm/4JjeEITkIlGEBNyXOBiXf7G0Coc2RZt5mIVmzzBmKArl1gt7mCGVfn/sZecqtwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790954461; c=relaxed/simple;
	bh=c8Ui2uQdljkfizQJxJXTO3Y+BpS1mteN/FKkUOLbueo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4rN0H7fOX9C+RfTLT9f2MXySotZ6e+ENSRocKJ26TsZzGqGeOQzqDhj5iLaSiBbccZfEEwi0yy92/p0VXt2k/KvYvv9gc5oe7bLjeJSXs+tc1j2Y8zyoCYooEf3UvxMtGMs7Z6bj+Qp3ZmMVcUtRM+Ii4OSuwVsIHjiPoKbWAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcuenG35; arc=pass smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcuenG35"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6e05989a25eso4900eaf.3
        for <linux-input@vger.kernel.org>; Fri, 02 Oct 2026 08:20:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790954454; cv=none;
        d=google.com; s=arc-20260327;
        b=kqiD3k5qSdLOSErpQkbcpHQ11fMPE0BEr/Fki9+qS1UbFd7oOqhvuIZxpEv3HorpRU
         vNmUvfGAMhvBG1W4T63g4ydcN+VMcv3duLtQN3VMkuCyRyY/boYQd8tzlDM5wVryR9vZ
         DQFMlUyYfuGJ9XoVzzIk202O0y3COstIA4lA/o5ThLwGL47smG7N2jOJIZNJgZZeATbw
         zYj2xhfpMA+CDdbsf8a400ac/qRTOliEoRAn6Cti7jDV5UYnbDYsRFPTWUhRmpVrD6NW
         qR3Y4njyWGPlMS7yzzhhv85TJ9gzB3YgBeK6skn+Th50zbTJ0YETNJ5X3jjQ4NKT0v9b
         TmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pRJcBvkIQpM6vnmBseq7C5SjURfqx9cLuKNSFbQ72co=;
        fh=fT5aur9fZMIfa/FBnsYDXcd1uKF5BbIQ8fz6+M0F2tA=;
        b=FFTTrA/wlbLa0ptqcrURDq/qejEqiQB6r9YACabhOO4wa/6JSClIgzJF+PlyD4ShfM
         s527L/OIFBrISNSzQbRAjxopIwL7oMc5EEQwhNVvz00cW3AbfFuEhVxBeap/gUvcj4PH
         QUCspmF2IGCNPkcubiMfvtmskh5gYZyJ15NAAizsaVutlcnAhdKmS37ryfcZNeEiWSh4
         rLiz8P5RA0cm8uz/NNjAcYXbmtffH6rTO4UQ8LOAgA9cqOjCGqG7kqUkWXnIaCbQyNh9
         3nj0SCCibBR76gcJwa7BiJUk7/NaFiYZFzCF8xXCwEDgTpKyiaDZC9Ifr4I0OBSIAsMY
         nr+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790954454; x=1791559254; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pRJcBvkIQpM6vnmBseq7C5SjURfqx9cLuKNSFbQ72co=;
        b=mcuenG35kUyrjl8BafkSn+d1+Ad5wZZVp7QGOEkvkFNvwMrdvo7MsVOL16hsoo4xgF
         aTdQFMURiGmg/GBn1Ooff8itLCA7e7bdybwAGCsVDHZSrY8PK+UXWrBe3qq5ix5X7zW7
         orOGrvHzuhwNIjZFjV8fz+Vw8VDVTvy8cFA4yry3FTMuFzHLVPbyBMCu5XjLztNbQKsj
         CX4a7dCDVWaUeOJMJXc2D6+w3J9hgiYt2HButBBvmyckLcdeKAIF43rKjT5S/x0lO1Z9
         W0cvCjOHxYpbpsLRL2eyr7pa9PDYrqQ/BNoHKFINhmGTFb9tRfJmmopIffryiQYp4u/S
         qiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790954454; x=1791559254;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pRJcBvkIQpM6vnmBseq7C5SjURfqx9cLuKNSFbQ72co=;
        b=HVsm5Ib54q/pLbFW0EKDvq+8Azoz33Crfgnunms1kEhRVV71Ct2ZH8PQ7d6ubdZ9ba
         FhUpeh+UI54lfQMMoLTMA1an4LO3MWb/6An+5+B1nHOKMMHnI6ecBhKHbsw2iMjgAv4n
         HxE/dWbtorkM0uZQlzPONmOlwYorS+vnQ7iXhE8nwlN64HsFk6OarV1IE6qHkaEdq93k
         m06KfD6hym7GNJtS/ZEAEEDbJx+L9z3oAciH2Tnkaq5aYQZbvA09Ep/3A1CQqffnWZUF
         v6/FOLew4VhUqybxflTSIp0X4atkDUqkT6xyBKCplxAwdclObmQtXaENLVFKUoPAyC/7
         /XFA==
X-Gm-Message-State: AFuF++lBY0z1xDsZdcntKF8DcYxczekzoiDnV2D2hey+Mj3WJNCR1vPm
	IImlnyhh0X80yc4cqKtzgOwbCZhucQzDYL8Mhp33BpmdKUFTiHy+B75yP9FbDumzqDxGZb0CtoI
	AfRz4AfszsrmknPIBEiJ+Ju8dKlTFM/qS/QEYClc=
X-Gm-Gg: AYBFou1hNpxhlY/CxvXMSy3a2fPgEHYLtKH5wohVE236aUpzoeoEP03RpbG+Kv74lZO
	27JiEIMOzb8Fq7L+QpDgj4adZBju86y/Myu8n0YecVuMQ+NtCDkmxVw5TKY+vgYOz2jYKimwsrd
	zruM8r5nAdn7WvIWwSk8mwyWjYp4I4jv7RCsof+sFUW4ffk2WsTA+ZV1362Yz0iX7Tm7dJbRXfK
	Yo9/+EWvALzk4G8bBqJHklls7B2gbMs4sDU0CANsJOPKc8RcieQ/0Z0mciyFn8O8QWOyaTfa8Nr
	tniVGfq1FF8orNvcIkr/8dQeJnyl0yPEH+kbVpKD3cNg0tLv7oEuZxbh8eLRMCb4RJ0arimSD0R
	RivGYwJJ4vA==
X-Received: by 2002:a05:6820:1789:b0:6df:5b31:f4b7 with SMTP id
 006d021491bc7-6df5b3205b0mr1758431eaf.88.1790954453969; Fri, 02 Oct 2026
 08:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADrS85612m-Hh-G4BJmOhy-y6r3Ni3kD8_GM-2QRBeWWEEZWuA@mail.gmail.com>
In-Reply-To: <CADrS85612m-Hh-G4BJmOhy-y6r3Ni3kD8_GM-2QRBeWWEEZWuA@mail.gmail.com>
From: Andrej Scek <scek.andrej@gmail.com>
Date: Fri, 2 Oct 2026 17:20:43 +0200
X-Gm-Features: AclHuK8klb-fvmewqmk7PkjTDnYTa3t-BgP_FVZnqttllQOZ5PBEMOmDlR84Ucs
Message-ID: <CADrS857iYjafXEZcHRSmeOFjrzs0DYG5Dp2PeS0n669cHBjAuQ@mail.gmail.com>
Subject: Re: [REGRESSION] amd_sfh: accelerometer broken since 6.19 ("Event
 data for report 1 was too short (15 vs 14)")
To: linux-input@vger.kernel.org
Cc: Basavaraj Natikar <basavaraj.natikar@amd.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, srinivas.pandruvada@linux.intel.com, 
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, regressions@lists.linux.dev, 
	lee@kernel.org
Content-Type: text/plain; charset="UTF-8"

Update: this looks like it is caused by

  0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")

which was backported to the 6.18.y and 6.19.y stable trees on 2026-04-11.
6.18.16 predates that backport and works; 6.19.12 and 7.2.8 contain it and
fail. The AMD SFH sends 14-byte reports where the descriptor declares 15, and
those are now rejected instead of zero-padded. (This corrects my earlier note
that hid-core had no relevant changes; I had only checked v6.18..v6.19.)

The same symptom on another AMD SFH device (Legion Go S, "18 vs 14"):
https://github.com/ublue-os/bazzite/issues/5796

So AMD SFH (hid-amdsfh 1022:0001) probably needs to be covered by whatever
short-report quirk/fix is adopted for this.

#regzbot introduced: 0a3fe972a7cb

Thanks,
Andrej
