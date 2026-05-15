Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185E83E0097
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861513; cv=none; b=Ngo6UdUFL/XY9bGm9ssyC/Iyoa7lJtuz2KGVDGWfd9yp/1F0AmQ3GHvm78NqkuuDc59DCXojCHnQzg2GBSEv+K70yHHcuuu6UdLd0/0zs6CvUxwgKKfk9Hs7YbbE+M/8WuOGCUHf7UZDJlWpiElc6AMwCUvkhOXTMvp/24av+Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861513; c=relaxed/simple;
	bh=m+RXjR8nAzv231UlDkcWg9DwGop1tH+x1SRV+qsOiBc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Apb4Qsrr4D3tz7x6W20BBxpkFTxUoRzSxrma7N8OwHRI3AqohfCnE6mI1LrZ4hiHmZqfB4VbelsAIIhM0tR8bHoIGo2eIBux74KdX+cUIaxr1IEgi2ydD+97xh5jkKjvqHK4HrPAImIhbSGfQSKXU6MlVyWo44+O35OZJ/p6Dl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3ZAEr2y; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3ZAEr2y"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-134fe980658so2024261c88.1
        for <linux-input@vger.kernel.org>; Fri, 15 May 2026 09:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778861510; x=1779466310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eOUGu7otXKU83Ptl5ObFnUx6XOop4vjyk0yP3QaWBlM=;
        b=D3ZAEr2yFsKyhwIiXMFMo8q8DbGGddroHuz4TuUZKqp4a46Gj7ebCLEFtlb+KFKKe1
         J9qti3xJgASb9RXIDIKV2qf53c+ZZbhlTzA3KYSru3PVd0q9ytu/1KAnXEpEl/NJyG+I
         v+lw2nCTM4k1jPXa/tHiLIJPJhzVM8zZG1Vci0t89BROYbZhYcFXr+aotRoncLL6aSdv
         k2tJkgXQe9QiMztcPudzKlNsQa2Rhq6uwnOEzpbFZ+wbAClLYDRne7T/6CmfI59uXvlL
         dAJAdUkD+6jfVJFZIMdSRqe0lTyqPltHpvIvspk8MDs6XT+ulEmtUivq3fiVMptnfLFl
         mimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861510; x=1779466310;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eOUGu7otXKU83Ptl5ObFnUx6XOop4vjyk0yP3QaWBlM=;
        b=dibj+E9O+HW7TpzwWkGv0FlRLEO/IUgzYBKMnRA+jyHcBUkGVYXqZh7CP0sg4Z7Bwe
         rfIAVYkBaW+X//E60wQakJSNhPAgYUqK8w6oIRZKO1A7HBp1HT240ImdS7zdASRyfEWh
         ftOSbSdufwh2O996JHck10/iqqSHnUUaMvV+TNLwgr+NUpsgAImfrHgMoEtLDXyQgqAC
         rrjlRkwA1jnbSeIb9a2JwMlmICmrAyxoPo8hOcdA9GvG+Z/wdszUwYto2ME3RI3Uzsbe
         ZbfwTysmAVesQ09Keyi/IuETfg7kci3f+U5hwj3Nj+pyj/nMPFO4sxw/nPOwV1NtFnmu
         wipQ==
X-Gm-Message-State: AOJu0Ywq1vwohlw4p9rqoCqYqOboVq7p1q7xm63NWDqJaFo7S7PkSpf9
	9Ltb5xR6CXNdl7mukdFLkdLsa2PJBNjdS0pa2TgxkBmqJm90j2xKLjLn
X-Gm-Gg: Acq92OHpdEiNqdo9xQDiJ1/flevSHmL01uurUVUhF2GIP+fyjs4NeWWrlnzfmGrU6Ec
	N3a6+jjgNsaPcHUAbpDSTH3NHV6jDyXXnPAvsgTMd58VTvmp32syATN3yrCKytdlh8d9ASgM7zQ
	zFmntksy7Vn/cOaDm4bZro/ntW93QypZqbVgKm5IpJJ+KCjXE+8IolAt1JbWroxNkDOfDY9FYKa
	ZI0E3UmrMAOQF2PYpw74dF06y5GBRX7BCzv8VbGukvLWCRZNrz/cL8s1oJq4BitBNRJ3BHSoMuN
	WaaD98uuyVRTtTAUx2uISE/SjDnDCVLGxJMJ27+PLO2d2TYjUMmaOChjaMvAfWDTzuo8UkRqANY
	YdvOiDOOz8E4OJAiv7qhOij/c7PZ62AA4wIFISp2b22sPWaJQQVt+gjs8HldVTEapej5qcKHQgj
	QK92CQasIR3zu94bpHEFRsZfrp0UmOPkwFlojzK3cCZQ==
X-Received: by 2002:a05:7022:69a9:b0:12d:de3e:86b9 with SMTP id a92af1059eb24-1350592f049mr2344958c88.41.1778861510101;
        Fri, 15 May 2026 09:11:50 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2607:fb91:ae5:914c:ad3:d358:6b31:e32e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbed2232sm11072949c88.7.2026.05.15.09.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 09:11:49 -0700 (PDT)
Date: Fri, 15 May 2026 09:11:48 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Louis Clinckx <clinckx.louis@gmail.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
CC: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] HID: lenovo-go: clean up USB assumption
User-Agent: Thunderbird for Android
In-Reply-To: <cover.1778701376.git.clinckx.louis@gmail.com>
References: <cover.1778701376.git.clinckx.louis@gmail.com>
Message-ID: <FC8BEE5D-FE37-4CBD-BC58-F32706ADE3F6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 15, 2026 7:57:38 AM PDT, Louis Clinckx <clinckx=2Elouis@gmail=2Ecom>=
 wrote:
>These drivers' id_tables only match HID_USB_DEVICE() entries and the
>code freely assumes a USB transport (to_usb_interface() on hdev->dev=2Epa=
rent,
>endpoint access in raw_event)=2E Make the assumption explicit at probe an=
d
>drop a NULL check that the compiler-level definition of to_usb_interface(=
)
>makes unreachable=2E
>
>No functional change for the supported (USB) devices=2E
>
>Louis Clinckx (2):
>  HID: lenovo-go: reject non-USB transports in probe
>  HID: lenovo-go: drop dead NULL check on to_usb_interface()
>
> drivers/hid/hid-lenovo-go-s=2Ec | 11 ++++++-----
> drivers/hid/hid-lenovo-go=2Ec   |  6 +++---
> 2 files changed, 9 insertions(+), 8 deletions(-)
>
>---
>Changes since v1:
> - Resubmitted on linux-input as a quality fix per Benjamin's review of v=
1
>   (sent to security@kernel=2Eorg; the HID_USB_DEVICE() id_table already
>    filters BUS_USB, so no exploitable path)=2E
> - Added patch 2 to remove the dead NULL check, at Derek's suggestion=2E
>
>base-commit: 50897c955902c93ae71c38698abb910525ebdc89
>--
>2=2E39=2E5
>

Thanks for the quick turnaround on this=2E I've already tested these chang=
es, so for the series:
Reviewed-by: Derek J=2E Clark <derekjoh=2Eclark@gmail=2Ecom>
Tested-by: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>

Thanks,
Derek
