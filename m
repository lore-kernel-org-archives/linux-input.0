Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AEB47B422
	for <linux-input@vger.kernel.org>; Thu,  4 Jun 2026 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577132; cv=none; b=hLNpOpUWkjMSn6nY66tac6F1iKldv7VLafcnt7511swPXsZBd1G1xoN4AYM/BN23kMO/on04mj7kVHxf9KpfopopI9kE2tBXe9A0MLTkDY9stY9qOLtFcj2B+vEFTpahMVWoxbp/ISKnNKhaT1qJkA4xMXJtUog9BCaOOqE0Yek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577132; c=relaxed/simple;
	bh=b3YXliyDaJ1o/zyoAfjoFNYgB3vDBwrgQGO1witBCzM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phcqRbHFpWaI4bKSIHucQlv6CvQs/JhOmVE20gMV6hisT9jFGdKulsSfiSjRoTV5vqeLvYEqr6OgPfmTHKXtzFAEMAIzBALWszzGWR+FImZIPcFWSCqQBwb593rVjdi1NnB1hC0nDWDu1ZRRZVERr6TzdaEE3cwOUU2zBf3ApeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWfOwRxM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWfOwRxM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE291F008A0
	for <linux-input@vger.kernel.org>; Thu,  4 Jun 2026 12:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780577131;
	bh=b3YXliyDaJ1o/zyoAfjoFNYgB3vDBwrgQGO1witBCzM=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=UWfOwRxM1ohS98UZe2oCTagMkOB8WDw1iKjmp+Hyx3hk0ZOvS0hR6sZFciUNT3xis
	 jHsRic1U5owsVVw2c2ruIrbC930Q92Vo3z81uvxGxM7buaJP2eOTKiFAfW9KTQ+2AH
	 lkvSHdfROZBe90r8s6YRvdI+835Ydc11x/SkvJM7y8a2m25nbeFk58HEnx5CgZXWZj
	 38qTbSmwC3zoP5mdgKcFuCm+wumRnhKzPxdoJBZ/Oji+GIKWRMJUkjvux9eKxDrZCV
	 wsoNfZTIqz1FT/gvUG+K+QwHQT6gFa3TiCyMK0czDOLtlS+SCoRRlRGtFmjWBeaKb8
	 YGPqVE1Ibjijg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39666ac91a2so18327001fa.1
        for <linux-input@vger.kernel.org>; Thu, 04 Jun 2026 05:45:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ99vapctzUlphuW1CpEK0kkRfRmjSeApDnkyYFQUxC0RJhvSi++H8hatzoK2R+vQZucQ3bKE78Na+ZoSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YygFpy7LNt7Tgs7lSJ3gMiocKHPPkhdUfwnrynVikFs3qQCX9T6
	KbWDyGiXiuWu+Z7nRIPexZmsCpX6Nrw15BGVoI3FY7NuU7b4Ug8GzoSaeeUotm9DKFk5MTVAn7d
	4CqLD7ETGvwk1ZWAJ5LGvX6MTBIA8AN+WJbcn6D2FgQ==
X-Received: by 2002:ac2:51d3:0:b0:5aa:67e0:11bf with SMTP id
 2adb3069b0e04-5aa80c0e6bamr1003076e87.0.1780577130129; Thu, 04 Jun 2026
 05:45:30 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 05:45:28 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 05:45:28 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260520-cp2112-dt-v14-1-b1b4b6734b6f@plexus.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520-cp2112-dt-v14-0-b1b4b6734b6f@plexus.com> <20260520-cp2112-dt-v14-1-b1b4b6734b6f@plexus.com>
Date: Thu, 4 Jun 2026 05:45:28 -0700
X-Gmail-Original-Message-ID: <CAMRc=MerS7MKzUUUG4cSzs0+b_a+NZLU9AcDszQZ8VrFcmpR3w@mail.gmail.com>
X-Gm-Features: AVHnY4IvzwkFz19CIkWXG1eYaKa3BzOYxUGUGN44w3XTGzgTIEIHVet2JfHcSoA
Message-ID: <CAMRc=MerS7MKzUUUG4cSzs0+b_a+NZLU9AcDszQZ8VrFcmpR3w@mail.gmail.com>
Subject: Re: [PATCH v14 1/2] HID: cp2112: Add fwnode support
To: Danny Kaehn <danny.kaehn@plexus.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ethan Twardy <ethan.twardy@plexus.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Leo Huang <leohu@nvidia.com>, Arun D Patil <arundp@nvidia.com>, Willie Thai <wthai@nvidia.com>, 
	Ting-Kai Chen <tingkaic@nvidia.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 May 2026 18:13:06 +0200, Danny Kaehn <danny.kaehn@plexus.com> said:
> Support describing the CP2112's I2C and GPIO interfaces in firmware.
>
> Bindings between the firmware nodes and the functions of the device
> are distinct between ACPI and DeviceTree.
>
> For ACPI, the i2c_adapter will use the child with _ADR equal to Zero
> and the gpio_chip will use the child with _ADR equal to One.
>
> For DeviceTree, the i2c_adapter will use the child with name "i2c",
> but the gpio_chip will share a firmware node with the CP2112.
>
> Signed-off-by: Danny Kaehn <danny.kaehn@plexus.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
