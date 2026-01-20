Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788AD33DEEB
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939329; cv=none; b=upFf+t/GM5zTGGwXFcxl7PIzxI7aoTzqFMis/xnMV0mpNaEA7Irm68fZncggbhgrAj/tbdv5NuVjXyp4u0EaSbfXTUArF4bzQWJHYClaNPdjcOu0ecOYixKwf3xQ2uPdI0MrCLs3hnmnWLzyD0jrbIOBJj+L/axH+NoA0MpDCuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939329; c=relaxed/simple;
	bh=jFGam1d3NuUGFPSwDVAnbHFINxd2GIvojexd1puh7Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hv/7fVSwJce3Vb+vsOICLGP4ZcQ7mduhZ7S6WVQVMcMS9MUUFbNoNQ3qQQJ78y5bVLvV5jF3QJ0mb8cBPXbmAhC3nFFQCpPHUc1WDCnU7FrwXIItw5JGWwPrrWtyCioJxnl/i5O1bLogLVJNyEzeJABG07r3aL9fOG4RzVQq6yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VouZY+WW; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VouZY+WW"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88fca7bce90so67116086d6.3
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 12:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768939324; x=1769544124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fa8n62Wco18BCB2ZMcBSBKouqOyAyAChJNgCLJGeA2g=;
        b=VouZY+WWxoQucVCxuvOHXsbiW7j+2SNXXzS/5ktjUubZmmm06zWUCzaCJiFsUx1w34
         IuJeZP2zRzwnWiQLtoFSnbsWXNXdgKmO4nxgVhQ7oe3CCGtTI/wi7w9rp4FK3l/90FYh
         Nz3nCtBVuWqiri5hb3BS7tlx75xyG/rDTUWUJBxrcBKAuVRrd99A1BHaCJ2a1XIlSTGO
         VullF0Sanw/h3/jAjpM1rCrQulmuLbAJX5z3l7ipGlFtztuFocwmPQAan7TEhYmxksZ0
         hfKlf6IY8oSb0tOvoxqQaKalbpKiZrWTc7lohBqn6Dn4QoKLNhLEJQu73tCqkalIt9Rl
         S+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939324; x=1769544124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fa8n62Wco18BCB2ZMcBSBKouqOyAyAChJNgCLJGeA2g=;
        b=W6A+TQ5+z1YJ5FGXli+wvT7VexZabFiqUWp07hiWML3onvtXRvi3jskmXG+xei60Jl
         n4dXR/3Mh0NBJK9mq+ppNknapA0O1Tk32oAz1Atc4OL9XhgQ8iVp2hVZhQ14oF4GUxJ1
         GL67QKghmsvaq4LMdDdM2HJezayOpkcabOgULKvnUfTAsIlnbnnlnQWYH1kDtYsc0BVj
         4pS9hnAKk8deBs94151l9ay+yaO/xzKZUdelmfkfrr4bsw2cMZPIBzyfGrGwwvnpKB99
         TnDrRieTnvNnYCsZvXSDFh/+rejHONuthzh+elWMXTMu3HWTzSyrhwFX+8vf1EHvOSoe
         85cw==
X-Forwarded-Encrypted: i=1; AJvYcCWx6N5/Q/AMNSKgOWa4MsubFNQlW9BUykhk3XgXcO/hx8LuCpWOc5qp/3mCu02/qR8TBCT1oeQCBgje5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqFTbC8B5APz9dbkilq1dLnlGfOpQtNo9gNJ4ayokoDLzMRi9O
	tk9qAMpDrsMDpJUArww4xeMKQSCsk9pYt6Hkm8OoY7i3Fzb5SR14YFvfsihLLQ==
X-Gm-Gg: AZuq6aIp1ZEZfAzSah98fAHywI/PL5tUHX4EVUFFniEY8YyhbSOGfpcPqLQdOo+R8GN
	XntkzD+Onjx2Fqq8p6qQn7FatiPuPpE3WxuoN59ZeAQTglkT3AP+See/Sd3MyvmX9zQlNVKr3cB
	C27Flc1RK1v73Fw9InmncbyWDjTN65HEBOLy81of9rA8fvzZTUeM/C+Pjn5gSH2mQDphXZ5SmrZ
	xl1iefPkud4uTANv99cuRtrxgFqT/TEX6RiQQ1p2QmpYXiWkUefAgpduLRUOG30gveNjdNQUFDw
	dwkcOLO6OIOc9cldkpTkavLun/R4S68MI1gFRIt64GkXjyHLLSrF7g0ZwRy3H+crXqaEzzNsDwX
	xdfQFuIOD7c3XFDoguCY0G2pQ9pEJ72+hMA8jdHsUTGq+W6h2eguv+do4+osrfblIU7qKrfAXWh
	SDVmWEix8rhBosiAFqUovCRn8mAS+woWgvtsNc9bqbIsKzE9BTkZiDnSZgfBczRGJXY7Mlc7Ejw
	IUTTzmh
X-Received: by 2002:ad4:5746:0:b0:88f:ca80:2b98 with SMTP id 6a1803df08f44-894638e2373mr41762706d6.27.1768939324049;
        Tue, 20 Jan 2026 12:02:04 -0800 (PST)
Received: from benjamin-desktop-fedora.mynetworksettings.com ([141.154.77.127])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a7298472sm1112863585a.53.2026.01.20.12.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:02:03 -0800 (PST)
From: Benjamin Wheeler <benjaminwheeler0510@gmail.com>
To: srimanachanta@gmail.com
Cc: bentiss@kernel.org,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] HID: steelseries: clean up functions, move battery request data to structs
Date: Tue, 20 Jan 2026 15:01:59 -0500
Message-ID: <20260120200202.1225216-1-benjaminwheeler0510@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112041941.40531-1-srimanachanta@gmail.com>
References: <20260112041941.40531-1-srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sriman,
As requested, here are my patches for your v2 of the new driver.

They fix an issue where the Arctis 7 incorrectly shows 100% battery due
to submitting an invalid report. They also include some cleanups of a
couple functions.

I've tested these by loading the module in a VM, and seeing that the
Arctis 7 reads the correct battery % through the Ubuntu desktop.

If these don't fit nicely into your v3, feel free to take what you need
out of them, or, once you submit v3, I can re-do my patches and
re-submit.

Thanks!

Benjamin Wheeler (3):
  HID: steelseries: Clean up hid send_report functions
  HID: steelseries: Add battery request info (byte flags) to device
    info.
  HID: steelseries: Use device data for battery requests

 drivers/hid/hid-steelseries.c | 217 +++++++++++++++++-----------------
 1 file changed, 111 insertions(+), 106 deletions(-)

-- 
2.52.0

