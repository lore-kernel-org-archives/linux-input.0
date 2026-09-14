Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94823427FA2
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378060; cv=none; b=h9Nvs3v7OpUwlrAJWDsJFJe/7JRSYm4DilN1jCSZg9qGHPK5M4hzm1chA3e9suAnNOpurDbF61cUBgPA9MaYZocrTCkZ9a5JehRhXaGsMHIylXbh2Oo4kyljeKPg6xqIzBSsCHwt5Zc/9kdyV4Tz7eTwP2VTjkoPLWM6sxbo6x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378060; c=relaxed/simple;
	bh=mP/l5Do4YJ7IRKmOSzDfTfkwiYAM0VDD1IfC3wKE9Js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fecopnPIQnGBe6+JpjvT+dyHb379g4brDYuONF3/pZbO2CYj+rN/K2ajMeckKnH5RdO1A7+lQf3oAbiickcAgjWl+2qkUcGeWLhwyHa0OWsp9qo67c386o8T+BbGeWCyqTcswibYChLQm+/y4yGOBY0tMIDHxe6aCzzm3jLNfKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ur1HjN52; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ur1HjN52"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972791F0089A
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 09:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789378055;
	bh=+EKK5mZN/Z88F3qSalRQdpIe1kQRO9isxPVk2e1xkaU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Ur1HjN52JEtDmwrp6C07kQ1Cdpj2A7qLwlCyaGMqCRBwBTb0j0t9NXb6d4Dfj0HCt
	 qnpk1JIh7nfUVx05gtYhalu0y7MzZI2YnpC00qbhPCU+0+9RoZckVt/Sj/ZLnx0ufL
	 6ii9jXER2PZDBgECWm1KvYn9ws0YM650hyvoHJPPNZ2boS1Ae4xnbFSorHjm6jEUJW
	 KIrrELf1a8Itan7p2MupPgw1b0LLHXDY7BfVQfOHcAtbCxj4jZDzoFz/6qE03UBd8M
	 4krfBaEPt4RPBi4qtw05JSIBwnPbKMTdrC0J6fUI55GWFTZtsW3CDJb/TeVyium0GX
	 lLocGxPvSI9uQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b76515c0d7so2867920e87.0
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 02:27:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx/2hR/pBbcP62XE7BrTu2y1zabEuZBftB/V0uH+UNnOxjldQw7AQr8bBO0ppHev9jhcosy49ATEQSVRA==@vger.kernel.org
X-Gm-Message-State: AFuF++ln3qdIu+UXEFWT74DVJHVY6QwdSRFH8w075AgoAKYc/mLXUl4i
	iBNvVY49RQSk1v58tZl+GiOHUJDFDd/G81b6JclfjngV5SEnOCIszRiuze870dRiUpWuCuY8NcI
	DFPQr0hec/2UZ1Rxv5j+a+XwXhP2WckY=
X-Received: by 2002:a05:6512:3ba2:b0:5b8:9a95:e251 with SMTP id
 2adb3069b0e04-5b8abb02f33mr1155329e87.25.1789378054325; Mon, 14 Sep 2026
 02:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827205116.GJ2943942@google.com> <20260827222550.24634-1-michael.zaidman@gmail.com>
 <apaLLD4ZXhNV-Dph@beelink>
In-Reply-To: <apaLLD4ZXhNV-Dph@beelink>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 11:27:21 +0200
X-Gmail-Original-Message-ID: <CAD++jLng_gdqoehT+c8sXoqy+tdUc7eAXXpAvhC_zJZwnX5tzA@mail.gmail.com>
X-Gm-Features: AcwNN1XIGrJI8kEt6FJvsnfO1yo_Nk4ZdgQyT1yCMtF0ThsxbTGwmmYyu4htGIU
Message-ID: <CAD++jLng_gdqoehT+c8sXoqy+tdUc7eAXXpAvhC_zJZwnX5tzA@mail.gmail.com>
Subject: Re: [PATCH 00/13] HID: ft260: add UART and GPIO support, plus I2C fixes
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Michael Zaidman <michael.zaidman@gmail.com>, lee@kernel.org, jikos@kernel.org, 
	brgl@kernel.org, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Benjamin, Lee,

On Tue, Sep 1, 2026 at 4:03=E2=80=AFPM Benjamin Tissoires <bentiss@kernel.o=
rg> wrote:

> TBH, I'm not a big fan of having multiple subsystems children into HID.
> Mostly because I can't review the best practive in each of them. However,
> for quite a long time, HID was mostly for input devices, and input is a
> different subsystem.
>
> That being said, there are 2 types of HID devices:
> - ones with defined standard usages (keyboards, mice, touchscreen,
>         battery, etc) and using MFD for those would certainly be overthin=
king
> - others use raw HID device with a custom protocol (cp2112, mcp2221,
>         ft260), these could be MFD candidates

Surely, as HID start to attract chips which clearly fall into the MFD
category of things, with a plethora of subsystems hooking into the
same HID device, we must find a way for HID devices to spawn
MFD cells?

MFD solved and evolved a system for handling exactly this type
of situation.

Whether there should be an MFD device in the middle spawning
each a HID, GPIO, I2C, UART cell or whether HID device itself should
sit in the nexus and gain the ability to simply spawn out MFD cells
from itself is what we need to figure out.

Yours,
Linus Walleij
