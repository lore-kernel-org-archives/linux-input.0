Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F483254B6
	for <linux-input@vger.kernel.org>; Sat, 21 Feb 2026 02:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771641241; cv=none; b=Gu+K0BBhHKksQt6I4nnvWqKb0SnrNwiVOSjBJ9/WQf+APrcBPwUPzKWU5e8hiJX7yn/tl0nN/rx8J6qQxdP9k3gPB1YUZrf7T+X8SEMszA7xF0Op2mALgLDW8AKKW+QVswHXw4FHUR08zOEUBwkbly43bRocHgPnwgqHujCubVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771641241; c=relaxed/simple;
	bh=veDyQbam6oMeHd+th8VZY64IVLFNrRoiaemz6vFNa8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLKjgQobpginDCH+17jwijSoev+JJjoK0oidFR/f/9bXKQm247JEz+bD/vH4cTONHRanU9UBvvf8vkFPoScdEDm67WQYawkDl2NgAi3/bn+CQBXQJLHcPmyY0qBnZtyiUhcU/Zk9mjXAZgFZ/WbkfeJCoMO9IUYfEgN1iDU3X0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAvXNIIx; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAvXNIIx"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b740872a01so5062796eec.1
        for <linux-input@vger.kernel.org>; Fri, 20 Feb 2026 18:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771641239; x=1772246039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CXUCmXCwP/gOms2DKxM3XqSr1rGtsoe0e87UdQIEtmA=;
        b=AAvXNIIx9NPF+v1FVLyvaflMU+N/EIIKAWUq/YgZrOd2DwPvOKke7pnUo6ZKDjkmOs
         GZBoUXfTaLgjvMT4XVs6wecFsJ7pebYQkS05prW/rgkh7/WGDbSPfg9lZD0Eucxa8BIL
         MBKyBiY6kIXUDjj6fmy4FpbF417eufRL7FALlxtO69MpIEH/Yw7hX6OC7lt92f8z2YV1
         V9/zCcPC9sU6FA/x/hwGl5WvOY9MbaDgHCDlBNGmzCr4Ie5ed1yn34jMwrDdVVRhW/Hw
         oMcQ5iLzXN5mbv6cillCiOysytQ0kt7Vid5hiWj700pTR/VQt+8MHxf9nyyA8EDUnkHH
         x8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771641239; x=1772246039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXUCmXCwP/gOms2DKxM3XqSr1rGtsoe0e87UdQIEtmA=;
        b=l/7M4waDPwiqxaDO7XF9X7V77eOjN1WzytxMDlT/1LEGTCtHK/23T8aYtYT0PRM8lI
         AjhJuoyPQZkj96pbah/s93s09z/5iEqzOFfNvQmsrJO6AQbCvOe3cLjNvUWb0DCsPjKQ
         l0lZ3LaFbwoVdkr1GpN867NKULPlZWEHAuofFswgvpuuOyWmJDq7wbAXZholaunMLoq+
         /3joXgTfnX+9jG0EdHzefIqDONx0SGV0mkulFQbwb7J7WeZGOc6zKhHn348JYY0cV6Lb
         An5PHd6Px0TLDF2WNti/72pGZaASIUsZsOoaEwuga6oXjpnNAo2MlQ2f50CCAIn3qzj2
         +n+g==
X-Gm-Message-State: AOJu0Yx5bwNbkE1OQ5iUIo2eE0Sr5QrI0Y/MkR4YG+DS/7l7bkJdJriU
	i0sFWGlhv51cTGAJS/90aEg0qh+09qwr4Up02LT26lq0GRh29nmqMbtK8O6n3w==
X-Gm-Gg: AZuq6aJDdiqTOIaOKSnHRE1x8ZZwui/AAvcWlV/+4VtXcUe5p7Mp2fnGNd4LMeP7QTR
	Vd2rqYcXtqax1BvqmTumnQ841W1JIfM81RjL/UAxMlnInul85Lj+LopQj/h50S52G3wivnIWjQd
	yWwb3jUpNik8b8Dfe0qnFpCSH3hnetib5a6JKzsnGNDn+5AA2A3mP386T7xNKMAHHOou7/YWelv
	oExq8b9gdEVYmMC2axFgdKyWQZdUQW4QyqYdbWwrZxKDatB9WLYJO+WaDzUk7KovnBAbm3XBx3S
	qf//7RgGCjhH/gGf1hOSjzPKLN411NxluhjHCNkTS3e+DZE6DZYXjREQZ8XWL6f5n6RvtHs5VFU
	gfQy7UONR8qHjilS5wNigS9p3kfP1tGMyVJrkkrRMg2RSnxg+/BcpOgcdaqScxwmYqsfeXLcghW
	J7+UPjid4AXQkq7GiebquSXfXtmb68JuobhSIVUNF/xG9jszqg4pl4PH7SJQeDd13N
X-Received: by 2002:a05:7300:cb13:b0:2b7:c5d7:84a2 with SMTP id 5a478bee46e88-2bd7bd59d2fmr1122671eec.36.1771641239015;
        Fri, 20 Feb 2026 18:33:59 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:30e0:64af:2b48:14be])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc37895sm607339eec.33.2026.02.20.18.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 18:33:58 -0800 (PST)
Date: Fri, 20 Feb 2026 18:33:55 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ariel Silver <arielsilver77@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Subject: [PATCH] Input: atkbd - validate scancode in firmware
 keymap entries
Message-ID: <aZkYbKNxGohck2sq@google.com>
References: <CACKMdfnPQoBnEhP0oCe1gXCYzJYyWBJsgHCHiMOn37XYYLAkVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACKMdfnPQoBnEhP0oCe1gXCYzJYyWBJsgHCHiMOn37XYYLAkVg@mail.gmail.com>

Hi Ariel,

On Fri, Feb 20, 2026 at 10:44:28AM +0200, Ariel Silver wrote:
> The SCANCODE() macro extracts a 16-bit value (0..65535) from firmware
> device property data, but atkbd_get_keymap_from_fwnode() uses it
> directly to index atkbd->keycode[], which only has ATKBD_KEYMAP_SIZE
> (512) elements. A firmware-supplied scancode >= 512 causes a heap
> out-of-bounds write that can corrupt adjacent struct atkbd fields and
> neighboring slab objects.
> 
> Add a bounds check that rejects the entire firmware keymap if any entry
> contains an out-of-range scancode, consistent with the validation
> performed by matrix_keypad_parse_keymap() in drivers/input/matrix-keymap.c
> for the same "linux,keymap" property format. When rejected, the driver
> falls back to the default keycode table.
> 
> Fixes: 9d17ad2369dc ("Input: atkbd - receive and use physcode->keycode
> mapping from FW")
> Reported-by: Ariel Silver <arielsilver77@gmail.com>
> Signed-off-by: Ariel Silver <arielsilver77@gmail.com>
> Cc: stable@vger.kernel.org

Was it observed on real hardware or this is theoretical? I do not think
this needs to go to stable, but otherwise I will apply it.

> ---
>  drivers/input/keyboard/atkbd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> index XXXXXXX..XXXXXXX 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -1111,6 +1111,13 @@ static int atkbd_get_keymap_from_fwnode(struct
> atkbd *atkbd)
>     for (i = 0; i < n; i++) {
>         scancode = SCANCODE(ptr[i]);
>         keycode = KEYCODE(ptr[i]);
> +       if (scancode >= ATKBD_KEYMAP_SIZE) {
> +           dev_warn(dev,
> +                "invalid scancode 0x%x in FW keymap entry %d\n",
> +                scancode, i);
> +           kfree(ptr);
> +           return -EINVAL;
> +       }
>         atkbd->keycode[scancode] = keycode;
>     }

I think you pasted this to gmail web interface which resulted in line
wrapping and messed up indentation. I untangled it but if you plan on
sending more kernel patches please try to not use web interface. Making
"git send-email" workig might be worth it, or look into "b4 send" with a
web endpoint.

Thanks.

-- 
Dmitry
