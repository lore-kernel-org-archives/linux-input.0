Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D587432695C
	for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769358579; cv=pass; b=Imt88vPE6Bgo1h5Yey7nT1o5xv6vcX+bBTszQIwkC89b15p4NOQ8usTupt6W3X5hyjZY4UzZk8Hy7Vy1LU1gnqZHKWvJH6A+k8gBHrO9WEbsFjpyBeijksR41ZvIoCBVG3uetRnyNwCBV5Zg0f4gJOAp1a5uhpMr0GUPf+SF3Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769358579; c=relaxed/simple;
	bh=B5Y6gSv84GWb8mDXHfMSjAEIgTEpWaSYcZ8NpmdLRMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEbUVr8mLgWTa37ZDKfyI1tbjrxkrUDjSoQwIKZNMbj34kCF1JG6o+oPCgRRqhz1cr5VI3ucNRecXwSRoB5+mtWr2e//f67FnUc9ADPGQxqk05coz4qAB0XtiORnAdHE4stolnW6GEkgWhmdO5fJw88HIrOsT5fKho2yZ4DzCLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5be61QY; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5be61QY"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1233b953bebso9623157c88.1
        for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 08:29:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769358576; cv=none;
        d=google.com; s=arc-20240605;
        b=XkFZTs5nN/Sj3POYMF5WHJ2mESB4E8CeOUn33RAvKX1RrAyp5zMDRjpP4hjrX5nlLJ
         lGRuJE/v6aDC+4JsotGoRSGXKbcfPBw6rw2+TsarY+zwmJQ5cRJR+BUI+akFtV/+AU1k
         qVi10E3tYS4fT0n20BW843ghMgtTHoCWzqX/wCGBN7IoHTIxYH3vR7rXyUHf5makpGI/
         r9VV+MVkHNwQ6gaK0mKB1gz+CYRXCftFm1uXl0Ies04JSGtH+YJg3J4sLj8/uEP8I8uo
         PG2i+A3Tp/3iBKN+zGtPh2xu+fjtcvbH0fOTRVl244C/RDxsEEA5q7Eo+fRxP3pyfZxn
         oPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=66RObo//D1wmoQi+hax3iyn/KXCiT3VDVmi4URh5Ldo=;
        fh=vVW2P9XsfiWlFiQEGLwd4hPrdV02c0CItMrwkzmAqGo=;
        b=kbvu4b+na5HIyx1cqJjL5rntMk0pxncWPEowexaLTTc5HGI5VJc+4ivWL8YCrFt48r
         YWpMVAgyIadU1atAfhxjc5z4UJgA9GKC5owSe0kR7ge4OlDulx25Y6m/pcGVTbmifn+1
         tfS6sqSzGQ8Gr6cemjJgh6qMzGC02GuhH/krc3bzuEMH38vTI92D1NhnYftECperuEDk
         WjAK3fueQO3aOUNVAbip4XwmlQisRSTcIrUQ5GzWt/u810pSlavFSyBAmhvy5emB7DUr
         IJdsalzyJjPaoEkIx9FvwWdkT8ASRnLz1coOKbCK9FDOCoecIYfG1D7BYPAJ9hXLl7uI
         fsPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769358576; x=1769963376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=66RObo//D1wmoQi+hax3iyn/KXCiT3VDVmi4URh5Ldo=;
        b=K5be61QYk6eG/IBBKuy4FOnetQek4cUxvwExmpTK0dLB6b4sF4HtgXvGkx9B7VB6J9
         NIm265+WQTKVbzVJ2TNdRd1ixUJxUvUf7zY4ZS+4nDXGlFd8wTPdMyJ4qZKGtPzQdSa+
         XlGC+smvzb6eU18VGkQXP+2Pj2duMvF5ddhYljpsYUfD81uSJpwntndVLNH1aCKkbINh
         sp/EAmI6DjjjnB4AeGc3R14GAwG7gP1MJFBGKTP7cVvwqYDB8UprPplIuA6gfptjqTNh
         iRTyhmkhJ0C/M6dun5Zyqg1OF5Ab/gOrVzd9W9cAuW1BZzxtx27B4+ZymaZs4atxgBqm
         X6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769358576; x=1769963376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66RObo//D1wmoQi+hax3iyn/KXCiT3VDVmi4URh5Ldo=;
        b=k+qIpCfcMRGxx/FX8sELoHEEjBPO4Ako/eU78ODvP/+Z+buqHLbiIuf8lhUkCY3bM3
         lMxWDL/G9c7SFteRAU0FxCSrSRmOFY95Qy++0rXEwGNzjQ3WiXCS4i273bJ8BtpKzVqY
         5JdhFtGJjMN3FS3q+KRqYp1wCHC+Dq5ixPRxIwRrQVxdlGOBWjw1g0EZFZ6d7SZ0+oYD
         H8GaQ27+CkKd0zg0R18XaJHUAu+hYjvPUgfEEpr9+zbu/nZnbX4arIa2AMLW2SPkm5/4
         ckqhvum0poJfCa15iUF1zf2VAfI65+xGM1dymXcYlpX7jF1zqtVieKmd4/tqZiobUATe
         FgRA==
X-Gm-Message-State: AOJu0YwB+UFGNf9enme24N5F8zVcJFur1kl+2kJlZfEsR2/3fAU7ZQXw
	OVH8gOfsZNSe3Lus1nCQ0occUAzwhnVq87SMCeFmH5I1dxHNSUQ9JvdZrLYNkuXczc8/W47Exja
	8Hu24wZ0HwQsJ0I+ZAID5fy0N+X+s/2lD0Lrh
X-Gm-Gg: AZuq6aJO4UCZdPtFWAAREFmsKcFyWQIIpa4KQBARXKbQ3seduzWKkj1gTzS7WZsepe1
	d+1rSBLIQ4mn981sPsUtjRKzjc5ZX+yIpJ8cnRx+A4WeogihY7/9foAC5bRRCOUqd2MbZ7GWBz8
	EyU8O+Lco70IjwreiMHPqhkkx6SkdNtfG9YrO2vyCL51gSZwjTIijtRAycsKe7WQQS8+b1Cz2kR
	rsBzHuvffGnJqyS9Tn5D5zLQbqqno6i8XaahK9Z5ntI7Gor+iCjCORes7iI8xmdFMVqK7FB3ZGx
	bdqGginnHKH/irOsa4iHHGPSojz6
X-Received: by 2002:a05:7022:a91:b0:11b:a3a7:65cd with SMTP id
 a92af1059eb24-1248ec27bf8mr1089078c88.12.1769358575562; Sun, 25 Jan 2026
 08:29:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ1CL4+DP1TuLAGNsz5GdFBTHvnTg=5q=Dr2Z1OQc6RXydSYA@mail.gmail.com>
 <38ea07c1-50ce-4342-aba9-fe2f4bc6c503@bitmath.se> <CAOQ1CL6G6eDcX+Qth3D531h72wW3RmvecCWjr5nAT-UdDWg40w@mail.gmail.com>
 <6880b5ba-ee76-4a9e-a116-16843a737b34@bitmath.se> <CAOQ1CL74A+WLY_f+QJHQqV=Wvq8yzJktLZ2ByZ4vjfUSsra9EQ@mail.gmail.com>
 <c2f1a90e-d6cb-480e-8f11-240b231adc84@bitmath.se>
In-Reply-To: <c2f1a90e-d6cb-480e-8f11-240b231adc84@bitmath.se>
From: Liam Mitchell <mitchell.liam@gmail.com>
Date: Sun, 25 Jan 2026 17:29:24 +0100
X-Gm-Features: AZwV_QgGr9vbbF7Gj_2XOG0rANlizQ1PaJi5JWEaJF_DKHYCgdSF1HjYQrV8vLk
Message-ID: <CAOQ1CL7royHBeeY-Qr-xBhvXkWy1cJZ-tcT1kS1Dfu_z3emN6g@mail.gmail.com>
Subject: Re: bcm5974 trackpad broken after USB reset
To: Henrik Rydberg <rydberg@bitmath.se>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Jan 2026 at 17:14, Henrik Rydberg <rydberg@bitmath.se> wrote:
> I am wondering if we do the wrong thing with the controls... for TYPE2
> (and many others), we switch between 0x1 and 0x8, as per the code
>
> #define USBMSG_TYPE2            8, 0x300, 0, 0, 0x1, 0x8
>
> But that corresponds to a change in two bits. Quite possibly
> corresponding to reset and enable. It might be worth trying a
> single-state transition, i.e., changing the row above to
>
> #define USBMSG_TYPE2            8, 0x300, 0, 0, 0x1, 0x0
>
> and see if that helps.

I did a lot of experiments changing modes at different times and this
is what I understand:

0x8 ("normal") is pause/off. If this is set, no messages of any kind
will be received.
This is not the same as the default/init state (sending 8 byte
packets, HID?). Even though the first config read returns this (08 05
00 00 00 00 00 00), if you write the same bytes back, it will stop
sending the default 8 byte packets. I haven't found a way to re-enable
this default mode other than USB reset.

0x1 ("wellspring") enables multi-touch packets, how the driver has
been working for 18 years.

0x0 (suggested above) also enables "wellspring" multi-touch packets. I
noticed one major difference in my testing; that it seems to survive
suspend-resume without issues, whereas if the mode was 0x1 on suspend,
it will resume, report 0x0 in config and send default packets again.

Another interesting observation is that the first packet received (60
02, "control response ignored") comes reliably 120-140ms after USB
reset. Importantly, if you send 0x1 or 0x0 before this is received, it
will be ignored. It will update the config but won't take effect. From
this state you have to send 0x8, wait 1ms then send 0x1 (or 0x0) again
to enable wellspring mode.

The above will be why my mouse doesn't work after reset and why adding
msleep() in probe() fixed it.

I think a more permanent fix could be to set mode on receiving that
first packet (control response) and/or on receiving default 8 byte
packets.

I looked at the history of the module and saw that the first packet
has been ignored from the first version so I assume it works the same
across all hardware versions.

Liam
