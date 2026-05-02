Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAFA28643C
	for <linux-input@vger.kernel.org>; Sat,  2 May 2026 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777734600; cv=none; b=FPqxKKwT5uW7RHuojG7Ysb8BhxE3AvhoswNLN8Ru+qd//LwKJ6w6u7FesaCWTvdo2EIo5iE9xYd94DKS2PPZZByKi15UQ14RyLbo2ZmcCDEyjV+hxHQytiBdMRmn1rV2AuVziPu7S/D4pVjG+ydKhYM1/f+OAKpbCML9zTdEp1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777734600; c=relaxed/simple;
	bh=ptxSujRFAo9vo0OGCu3Zr32RZJm3vWSjYX0mK7rYhT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e0CQIW42OtrcbD0jGL6+n8W6+n0eCe59J83XIWWD7PK15kKom4ldRerctYCwvge4tuIVXFwFpu6XRVyAY8nEG+2xGi/Y0++ahYlXVlO5AcK8mIfH9zXzy/fkju4QhHsU4Yg6/7VXeZQoSAkdIfY+ikOglpRzHrhaaSKizyJlSPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0vJCufK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0vJCufK"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c801b30188dso72977a12.3
        for <linux-input@vger.kernel.org>; Sat, 02 May 2026 08:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777734599; x=1778339399; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Eq7tSSSRZQ1vJ+lfSbnUOmydYvdp1sAAcJl8m2PMdu8=;
        b=G0vJCufKU79nK7Fg/wYJ5+OkYyjTIkuD0Rm1XMm62EbeK3skywJUPa4TruKZ1Vae/6
         e2rsi2HNjkQaPjcbBBkezbIhiYMd6PztE+ydxsjNhZxJ0wtfMHNPTmGhp2JKpN6Pc8ZQ
         zfMq5rQmg5hdY8MYalGwgIwMQ2m65Ba9oOC2pBZyNfZcz0ZdtR4Ffk16T0nXm1rH7gI4
         0uvDVBs7LCDciUgJiDwAchCPU8JjmrOUsds1skWdO6kvFti1n+80m06yfNiRhCIELfPt
         pDLDUCvtO9z+vAHQe2vJiNe6kECCi7pqu17U7smLbO4QFlRh5wnYXh9Bkeq/CoafeMdE
         lwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777734599; x=1778339399;
        h=mime-version:message-id:date:user-agent:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eq7tSSSRZQ1vJ+lfSbnUOmydYvdp1sAAcJl8m2PMdu8=;
        b=URWJR4A1nrAisPgFHKM4pYfPpDtHKJMvkSYWWZfPLpIirOBMhEytS3uwF2oCoh7lAv
         TzF2ARQDcDBw41/pxH2we8qRDjgqpItYcIyq0k55mOXeh13W+xbJLLdWbLYw2VF/oOyX
         oJEnwIYSjwv4+W9URke/gXPSd3r+vPOVjyJFkYLW4g1RNXolAjBTzwxrPDVHeyh0M3MU
         i5xlkZOWIj6sRfE/zlUHulwEo8b9z4teITm0enMjbsW5cYQOi4l31L7h7uosKcvxO7bd
         9p+UML82k6l3bdmsApntUxQw1f7aH0pzhVJfoApgplBz3uWM0HrKHxeuCjTnew+R8xbc
         +f8g==
X-Gm-Message-State: AOJu0Yx+W0ONE1poAsogiibpyMCNaFZoC1EpAT6bcIVE0hXxLFGW2PQQ
	zwBr8FoMg7z9wWo7spPkaZrvh0hQ4TrVld36QWl9tDqVcK8sYgh2DcqFOvIIiyewOjQ=
X-Gm-Gg: AeBDieseYX8fgegh/notJDMadDKmAOUWyrKAvYoarawUPVS6IKYrkO2Ny9t3JpeKzyu
	/ozqEF8xtgeprAdk2lUEPUNBkGWvtU232ddc6bn5ECXK2vRoOU+tMiFhSSKfOCGxyNPjXgGObpw
	jOFVPClykDhG3HQf59sD12pI74wJRZNfxJVSEVDl5zIWy7YU0Au1ucuoKk1wivWN5/j8GhdYTHv
	w8WUMqrPKoGmWqfX3R8ex9qmqVCyPpkkt58UAXDF02sPSvGliI2BaroIXcN9F8hAN7/EA1mvOLZ
	iEquVVv38hBEaTsb7ySpGGO41kSaFT7FqQsgva3Q7c+8muywytAKUjRji0VfB53A8WuZTs2WHHY
	gbONgea5Mj5FOd0VjHwd3qj1m6XNFA3+JABWI6OXSTxYRBv+SLOF/Ss1aQ5jT9GMKC2RNhJsoev
	kUlYLcrmayOwNmn8gCtPHZ85vWXj6yure11DvYFSyWERWugQ==
X-Received: by 2002:a05:6300:218d:b0:3a1:1120:7981 with SMTP id adf61e73a8af0-3a7f1b2ec60mr3273184637.20.1777734599100;
        Sat, 02 May 2026 08:09:59 -0700 (PDT)
Received: from localhost ([49.36.181.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c801fd404basm502800a12.24.2026.05.02.08.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 08:09:58 -0700 (PDT)
From: Annmay Arora <annmayarora13@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [QUESTION] (Resent) HID: Lenovo Essential Gen2 Fnlock patch
 (1a81:1026) 
User-Agent: mu4e 1.12.13; emacs 30.2
Date: Sat, 02 May 2026 20:39:53 +0530
Message-ID: <87qzntg85a.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Resending with corrected recipient headers (previous mail missed LKML).

Hi,

I am working on:
    (lsusb output)> 1a81:1026 Holtek Semiconductor, Inc. Lenovo
    Essential Wireless Combo Keyboard & Mouse Gen2

to bring the F-Keys functionality to parity as under Windows. The
peripheral was observed with Wireshark (4.6.5) and USBpcap on a windows
11 LTSC install. The SET_REPORT to unlock proper functionality from F-keys
is as follows:

  ON  -> 06 ce 01 01 00 00 00 00
  OFF -> 06 ce 00 01 00 00 00 00

where the ON state allows the user to interact with media keys (Eg. Fn +
F1 allows us to toggle mute).

This was tested successfully  with a python script to enable the Fnlock
and later with a out-of-kernel module which is not production ready and
would ideally not be upstreamed. I have a few questions in order to
attempt to send a few patches. 

Questions:
1) The device presents itself to be Holtek, but does not seem to match
the manufacturer code. Would another id need to be added to
drivers/hid/hid-ids.h

2) Would it be ideal to create a hid-holtek-lenovo.c or should one of
the existing drivers should be modified? If yes, which one?


TIA,

Annmay Arora
