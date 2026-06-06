Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93A33B18A
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 20:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780778836; cv=none; b=HD+Ri0cOYKkez6ubJhTdmVtZRSKaby4XtGp7w3CH9lYlq9VNL/846s9WsqcBiUj6VXDk658QOrN+BqtEN/Rjfq+FEFWuz2c1ap/lpL2k325oi+KJexei+hRh2PziCTmr0aDmkQVJVyrhunDVrA/3rfhhWqkmeqJkdGFJ30Y6xlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780778836; c=relaxed/simple;
	bh=181AFBKPeWEi7rWBcIQMte8t40cQO9RGFXJmw4crqZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiqRxkD4P+NYtu65OxoJXgTRW/gvUA+syOX4NFliBkT5tXnKhJJWbMbKTw4RejBdpz8fNLhj/XEmObx7cSH3F5Ne86ptGzviYWdrK7qT4TRLANSEqR6heFpObFYOdQtbnO6w9HlEqJ+aTQ3pGH2OmlZnQhJf0PcaI82eBe58CMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ovz+5Fls; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovz+5Fls"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3078e0dcd67so1081851eec.0
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 13:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780778834; x=1781383634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ur7qG5cLB2Gls5K5mQ7h9ecjj9T6I+5G5xBXAVBeHC0=;
        b=ovz+5Fls6DVg+fH35VGUmPJMqtTtECYE2dZ5HckdhB0q+IscZm+UfV4c6r5b2yWSqS
         TS4MvwUeJtUJA6b6CWuLDZjydxqyVrNPEW1zmi8RZVDWzUlgFXdU9FS40PvdnTGslRGW
         JrrdlJ4Lz5t80T016WRY/8GcbQ2TybDXOT5idvNPv8Ll5s6F8fbD0uVQCLT6s59hkbiU
         EXPXifGq9WvXLi7ClwUB04iq3spyjoa0rAzghUG47AOyDwevoVkl03di2cpww6LGyeDn
         INkB/R4kwRJzsPyFULgPVCSnAJMCRjvj+yDCUUjnLXjMYpeG0HW4QzTIvtmpOpKf7oiU
         ljiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780778834; x=1781383634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ur7qG5cLB2Gls5K5mQ7h9ecjj9T6I+5G5xBXAVBeHC0=;
        b=AdRPHoYGyk4MUU5hJ0Z/OAPlJoUWdn9E9jXOkjM/IlSHJQFrPezvblQAjhlAKFBknv
         a+uPBdYPLJacC4kLm0rP0l/dLJ0gP3Ftbc/QvlwhBH15WciqGBUTZFTEEJdzSHnohkbl
         XXrjRs5BrJJVFdx2nn/mKaJ72w+553/q9Qm6rArR8orXM2Ctd2GDRicDhJj04mrtkxAH
         y51OcP/+wHuabJq0M/PaK5DKi6mDs7gQtWW2mHyuOkU4PYi53RLIKOd7oyY+aOicU8n9
         DyLKlC+jZopiOD+zq+E0gIjRMtk7x2MuYldWq6kPcIbPsuKkjI6+II43vvrXee5uJMRm
         7A9Q==
X-Gm-Message-State: AOJu0YwBsBWoUUkiw24f8Ep/nRztlh2MVTieP9G2a64OJ6Qu4uceFErE
	JK+9yZjOFGj20PfhZf3WkTdI8a+tbqutv7r7iA20JmnrI7s3FUT251AI
X-Gm-Gg: Acq92OFpMd+iL5IuPshnLUpMz91l4PE+D/qpezK6RLdWmtSkaIOsFgX4R+kNaNrkfAo
	J2BygH1Vm/GAje69ilGhVHdwyEu83e5POVXd6c1lEcWtXqiaSXTPED65ZK5KIblZVp6yqOFKrnq
	fRTVP6EVQTzodIekrI9eUOa+xX0qzhQXyYci+43vSlZhArFNenjPJ+7WLrJi5FKOB3jG5ij/abs
	NciJeXcbLjZVkg2ebljY37GvnJPF3qSaZnAI4vvNJanjHKOWP+F1wiHrL21ptSX2SWUAJMAtKZ1
	0YAbR3E2nESoXw1xWFEGj9NDY2sczVDF3CieATkRLgsCNS4MMoO+S/vtwT3Z31lr1GHoCkIYQk0
	cZy/Bfc5APybX1jmyA6CfQMNufRmfV31HZ7ud6gAZtL8hkisDKIbJRr/HB0/SU7EAbBd6/vWSRb
	4W+Sca62QzVBmuo6JhuXOQIU0g1VL9WeBg0exd+EUtVVvO/Y9ZgMRIirPI3LlHwuw06fL8Nyt0D
	bE=
X-Received: by 2002:a05:7300:7488:b0:2cb:4b8f:b2bd with SMTP id 5a478bee46e88-3077af30ab5mr5573481eec.6.1780778833808;
        Sat, 06 Jun 2026 13:47:13 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:bb2f:1c0b:386d:8909])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f716017esm12748510c88.15.2026.06.06.13.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 13:47:13 -0700 (PDT)
Date: Sat, 6 Jun 2026 13:47:09 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-input@vger.kernel.org, Michal Simek <michal.simek@amd.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] Input: xilinx_ps2 - remove driver
Message-ID: <aiSHSt_PWzaqalec@google.com>
References: <20260603054217.442016-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603054217.442016-1-rosenp@gmail.com>

On Tue, Jun 02, 2026 at 10:42:17PM -0700, Rosen Penev wrote:
> Remove the Xilinx XPS PS/2 controller driver. This driver supports an
> old Xilinx EDK IP core that is no longer in active use. The hardware
> is not available on modern platforms, and the driver has no users here.
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied, thank you.

-- 
Dmitry
