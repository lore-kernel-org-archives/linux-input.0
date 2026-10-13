Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBFE4EBAE0
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791935630; cv=none; b=pcfoqvkROZblk3v0VSXrFCgpnxCT319uEahDMUZ6hRjEP0Dg+Y3B9vlL27yvyVUBeoskc1KeJs7SkIK94fs02+aXhHOXhv7SgPVDzxKCsZxEWS1ijfg2Q/1l2b31m8BmhWa3LRmay/+EfUt/4kjf7D5OXd2UsvMEbE9hRXTiCcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791935630; c=relaxed/simple;
	bh=8t/CZtcD2UDRis6ElxpuQTCnGFRZydah4tW3kas/HT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7/3XS17sspSUhNa4EDwwqRCNX6R7j3/KlDzU817NYr6xwO4+u0nIxmxi5jTOOyOWebpZnk5lrue9qN7D6DA1pfRvxTxKI4LMppxVZeobY9hmQY+UVeDZK8kMnZBORwU5upbzoTynR8RhvF5vdJANJ4TlTyY4wGvRqtnTDWNwG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ct3VQvyD; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ct3VQvyD"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-141395927feso6720738c88.0
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 16:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791935629; x=1792540429; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TgjzkiHyd5GOcR1gXfvNcSQQu/ffNPe83SfrCAvR204=;
        b=ct3VQvyDr51QdjF4N3RMP4dhd0HNoBN03GPB8RfEbZ1dnKAZrJP24ZWjQt/7NEprSH
         gxiq7X78FwMTLXc/TUV4q6eSq7q0AyKFF5L+I9VK2+mJwC5bir6TXZCvdnICibN/tB8+
         WL4q9uHaC3ZzZmG8igqb2QXJw3/0WnfBB6OxOZD5zRJamD8brRSRU+69TDMpyyyeOtrm
         jgX/VjMCqUHfUwItMTXinHMTKrCG93ZbG30is5OepZ22+27EeJrk0sI9XJaC+l9ckwcQ
         dw3xxHMcoJXCRFIK/M3ex2dzJ9R9/+en750GqKUXmypQcs7bsK8eChNOb08KH6MhJFHa
         FWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791935629; x=1792540429;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TgjzkiHyd5GOcR1gXfvNcSQQu/ffNPe83SfrCAvR204=;
        b=TlP3E8OKUxcg5G1eLbk7wq5V5fupLw+CIvFRTKT1cWbz0qmtgQrmuzk69nr4gchcOV
         2/KV4aMp0TKeoqHFYziRnKVDSZJGPpuxUW0E0hhiIjq8BIj0rAEh0jI6UCxDa6UCwz9k
         atiO5HTkwhG0DvVhUUbXJXm5zQoQ3JSjvpxo2vCFPYb0ywO3TzEvdixMsjCCcPy8YTgh
         TtQ+2+XL/Qm+4vTAwIzPaDZ8K88wMUttPlDu5Kwj0ygA+9JvcBLcCq+UJpUHxy6TOk/l
         iVayfYDPMlLn7x6ueauCWNo4T+vJAVAp6XhatjOitR1FJxybpxjw89hqfCiqIX6MsR+/
         PjFg==
X-Gm-Message-State: AFq9FYIdonYyS05HyEY6doqJRBu0PKXJIFJHPKVdw/D6Glfz1Z1I+ML8
	06htue+0+UN3ZufFu6y85Uqh+zIG0gbhnWIdL0d9+Ymwds9vIvA5LziK
X-Gm-Gg: AYBFou0pRI1jbtMp2BfgemnJRAr2lF31TnS44oIkKD7wQanROPrQCE9OGAc4H6KAsUh
	8qs7DxbTHkeQIuctZYhfuWTTDZ/zSzw3tPVOwsFchCG6eSRcpNfV9mXn6Pt0khgKbyFWWbaJdvC
	VMhZe/21Q9TMoMBR0hsbUljI6GHkrU796IARY0iIj/1r0R2bjWFxH9NnpzY7KhemIw0bmMyATHf
	3vuTYdfzB29JQtaUSn4mDoQTCYJS/h+mgDriW5FaoEivhk87sPzgrr23DpS5uEzed7BohzWu7YI
	btvLYxw1oqSUefKQy2/IGMOCyvsaG5YxflKShEQOUwGRUMxXyv79zXUpQbHbZ3panuLSasESj9Z
	s4MQCbhATP3EhPtWrXuEEONVfYU2Nw4HqxN2UX/3nV4ZIvSpvdGA0yI96RYpOPpOtSgZH3R7EU0
	yWX1qh3yBsYvSF3PUxYJ4lgb0hlHej905iLE7NNHLrwTGL4z0tWl/t+zemAkW+h56WLZeEGj5RI
	uB+wsiV+cLKIvjbSTc/X8G0Sx/ZULXnSJeeJwY4
X-Received: by 2002:a05:7301:2809:b0:351:202c:c7a5 with SMTP id 5a478bee46e88-3537dba640dmr19039688eec.0.1791935628772;
        Tue, 13 Oct 2026 16:53:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:875a:117f:b9ea:5a08])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2954bsm48201384eec.26.2026.10.13.16.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 16:53:48 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:53:45 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Peter Hutterer <peter.hutterer@who-t.net>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Input: wacom_w8001 - assign distinct phys paths to
 pen and touch devices
Message-ID: <as7D7idd-843CJkn@google.com>
References: <20261009190746.803607-1-dmitry.torokhov@gmail.com>
 <20261009190746.803607-2-dmitry.torokhov@gmail.com>
 <CANRwn3RUdGyEOJEdN1xUjEHwnBX5-UnpZZ+ZBBwY9RBB04FtUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANRwn3RUdGyEOJEdN1xUjEHwnBX5-UnpZZ+ZBBwY9RBB04FtUQ@mail.gmail.com>

On Tue, Oct 13, 2026 at 03:42:10PM -0700, Jason Gerecke wrote:
> On Fri, Oct 9, 2026 at 12:28 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Previously, both pen and touch input devices used the same phys path
> > "%s/input0", which made it impossible for userspace or udev rules to
> > distinguish the devices by physical topology.
> >
> > Assign distinct phys paths by introducing separate buffers pen_phys
> > ("%s/input0") and touch_phys ("%s/input1") in struct w8001. Pass the
> > corresponding phys path to w8001_allocate_device() during pen and touch
> > setup, and drop the shared phys buffer from struct w8001.
> >
> > Fixes: e0361b70175f ("Input: wacom_w8001 - split the touch and pen devices into two devices")
> 
> Does this really deserve a "Fixes" tag? This does not seem to be as
> much of a "bug" as it is a limitation. Userspace and udev rules are
> (currently) able to reliably distinguish the devices by name.

It is a bug as far as input subsystem is concerned and it was introduced
in the above referenced commit, so it has this tag.

> Obviously that's not ideal, but I don't see much benefit to this patch
> getting backported to the stable trees -- especially when /existing/
> udev rules aren't necessarily going to know what to do with this new
> "input1" phys.

Right. For input subsystem only commits that are explicitly marked
as Cc: stable@ will be backported to stable trees, so it shoudl not be
a concern.

Thanks.

-- 
Dmitry
