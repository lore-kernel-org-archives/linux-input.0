Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8695C46F4A6
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165065; cv=pass; b=hBQR9BKvIxlAcE/+yFU+F90N2fB7s++UpEsGZLfSpUcA9CGHipBK3BlexawvZ5K6f4gVYSss4LFy96ohPtWGB8+GMCpZCGhuldJNVJy8gfh8Jps2gGsxd/YdWdcSghvzwKOJnyMfu66h46HdnTY92zyncCkw5m55MwWNZgYEo5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165065; c=relaxed/simple;
	bh=Qo77gaAgVQTP0Wo7RjceELd5Xbc+Xpcpp+2uNGjS++w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgY2SxeivcPji1meWt6TiH1lPLTx0BV0/+iqsDEfmBbZ/sQjoHP9ErGDXmg2LPDyG1/ctDs16bAyzJ+4CQUFOqWGXxAAQbvhmrqfhGKLmipWmdqUB0QbGaMjqD709M1rE6k1cFhOD9pFBNRQUZbri7vkwyh0BY9dFYrhhx8XEfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRTdXlBC; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRTdXlBC"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-872024e2b4eso32580b3a.0
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 08:37:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792165064; cv=none;
        d=google.com; s=arc-20260327;
        b=NzPRJsiWcFwBVXfm1cV3FMO2apw1W+ZHQjj48FwoFI/S5QP45A3GHdIgkLoBepa92y
         PBZTGnNEfHer5SXczAimkL4TOwn55YeCaOXZtZ75FwrTDeL/hno55oTw1qM7jxUsR9zA
         43FiDoOVhvTufdoyYzO3a+/XQv3NVGK9h4rRK00Wcdpg+P9Rx52z/1wMLCqnIF7CSqWG
         MYVJoEz7nSkPE5eOrmkioPZ91jHCYWqaHqcW6He2sEKC7tD5aWz/gFpKJx5YT9on72y8
         61f7fs1ITbrK+uQG6g/nu/5gt3BoDKf4BwLaU9ugm9RXKfmZ1aHfGerqIGfb3xeKi8GK
         +J0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IYVNPQuFkI4o7N7mZVUWjjX+AiySaZaN5/dMXjnZrJU=;
        fh=l1x4y/cH1DIMLERwpTP3KJesnXEUUzgPjgcYF/j3AY0=;
        b=hkWpSUFTISQu7QWN+g94ss6175kvuGwoW+45uN9TCvxKZK5lYqPVekQXSkhr3GQs4s
         lrqDd3lr/vTEtvGN6muxZTCy6mXyw2M0Du1L2ORb9ujnCvHOatOX1zV4tKT/kJXE/+C9
         o/PbVaROk7RdJrCxk6z1IqY1eowoPx3ra7UF451OZFk7HOQsN5hMRCPF63CW3+JR4cb/
         hZu1rSzulLr+QDGLjZCRKEbSytjtx7F77UcFBUguaUUG7J9AqYOVvU4LzhlQJ79biJsU
         Xc/Ss9XcteAb1uYaQJgPT2y5DJvqmhuLARspUssBikZAEWqJsIh+EnF1HQMyW59iLvXW
         J87g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792165064; x=1792769864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IYVNPQuFkI4o7N7mZVUWjjX+AiySaZaN5/dMXjnZrJU=;
        b=SRTdXlBCvekoW5PINPfdV49NohxYPgGQRBZm5FnfVUnxNnuA5BuD9mdSpi/TIOqEOR
         fgKMn7C/WWoHD5qgRmYQT0LpiUN7yh7lCQgsbVQFtXrqj3sBe2UxFw9uXnqK34Nuoa8O
         Mhzz3hJug7hyo/3lxJB261gd43bsgiVl68BasPR5ovDk6bcw1gaODWlVwbd0Qup7pyXe
         MwSco7WjEDOQpZyYVDW9KU7zT+ai9JcSwgARCYMW5n36/nwnT1v3kto00alV9ErloH1Y
         ReGPSWhDj9t54Yl9u3M4jsAJ+YNBaINUBE4BGyhdT7w+6VNtZGqXNxoRHdQWqiDLprNc
         etcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792165064; x=1792769864;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IYVNPQuFkI4o7N7mZVUWjjX+AiySaZaN5/dMXjnZrJU=;
        b=rGhBaLnGr1nFfAzr8PPU0PuWy+0CpmmCaKeOLwWEuf29569EkQzcHXxMRjRg1wvd5z
         76BFA5qM2rJ+XkJYo/Wzldb7UeI7FUWZ3qwSw+MpceIvoGODu6WyhdGCmzuFJJJM5sLa
         fPGZHdu388zqkXtEg17ZNe5HnENVmRBq/lzU3VzZCdjP8dTiRFo/faTGjvRLHy6bNa+f
         SgGU0KUNcKHAxSLwNfgpRFK0vkECKwlK5Vm7DnWcHhqg9pbRnoUxmX+DQ+0zmd+3Pl7t
         8ww+XBGRAeUDJxXLf1j4PWaX4/FlnHCskuII3/Gw6PHjrxxXV0hgJfg4hVjRV3buFUSv
         uUew==
X-Forwarded-Encrypted: i=1; AKwUvBwma0sLXIgP7DGbCeIuVuYfSKw9WcRK4gf5E9gbaEv5OALBHJmA/+URb137fnbMYZQxLLL3uEA0vRzodA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIynZ4gP+aOe+th9oJiEuaW1lc2DqisxKdlYIgeXPCKjGMuLrXJ
	mWlkwCzwDb0xIhga7LG8XI8KuCivnkFYXwJgPEyuobxmc1FEOllFMT5e3NCUVq7sTioa0xC303R
	0U0r/tSxxeCq4QzBit/pfeKQ9iApA05w=
X-Gm-Gg: AYBFou3gC3TBFAuuucKWZgGcac5rGcgBk0OCk5IjYeHB/m5rQvDHeB53be2aLhfQRBO
	6qw3nyNiHQOPeaJl26Lv4xGF+2Y30VmUVygNRODjJ+RMfCmvoRBSFrvxMpofx9EeBbvOW3gZitN
	rGIGhM4lrsu51h3tgUNGc9WntFackUAiehCSIYQ2h8wLf9dH29WWTrkfK4k84BYCYoawrdHW2X4
	Fifv7R1cvzhIxz/KKZe8KmuVAswKTVXoCs5qQDH5cWp9EZTun5TTPrKZM5T4ANnFN6V+i69tSuF
	HftWRvYQYUpmemCEWe0rAofQZ5BB2vFBJBSbA5eHXIBJLDuANbyOwtD9
X-Received: by 2002:a05:6a00:4b42:b0:888:4f06:903f with SMTP id
 d2e1a72fcca58-897c78d5fe8mr18023757b3a.38.1792165063703; Fri, 16 Oct 2026
 08:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788222001.git.mradityadash@gmail.com>
In-Reply-To: <cover.1788222001.git.mradityadash@gmail.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Fri, 16 Oct 2026 08:37:32 -0700
X-Gm-Features: AclHuK-sUJKTjgoZIBWIIHtbP1GEijbCkJsUj_4hV98hycsPoEpLJOyCwEPUX-4
Message-ID: <CAFqHKTkStExZHvFKP0Kh8USQaGfx0jXO5QmvY4vNhT0eB6ENSw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] HID: hid-lenovo-go: fix controller configuration
To: Aditya Dash <mradityadash@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 11:36=E2=80=AFPM Aditya Dash <mradityadash@gmail.co=
m> wrote:
>
> This series fixes several issues in the controller configuration and
> calibration paths in hid-lenovo-go.
>
> 1/7 fixes the calibration attributes, where the command and sub-command
> are swapped. 2/7 fixes two right-controller attributes: imu_enabled
> selects the bypass feature, and reset targets the left controller.
>
> The configuration interface initializes its command completion after the
> HID hardware starts and opens. 3/7 moves that initialization before both
> hardware operations.
>
> Before 4/7, any decoded configuration reply completes the shared
> completion. The driver then ignores the result of the wait, so an
> unrelated reply, a firmware error, an interrupted wait, or a timeout can
> still be reported as success.
>
> 4/7 tracks one pending request in the driver data and matches replies by
> command ID, command, sub-command, and device. It initializes the new
> completion and spinlock at the pre-hardware point established by 3/7. It
> also returns request errors to the caller.
>
> The firmware has no sequence number, so a late reply with the same tuple
> can still match a newer request.
>
> The remaining patches fix calibration status handling.
>
> The calibration status table defines 0x00 as unknown, 0x01 as success,
> and 0x02 as failure. A Legion Go 1 returned 0x08 after a Stop was sent
> while no calibration was active. The driver stores the raw value as a
> status-text index, so a later read returns -EINVAL.
>
> 5/7 preserves the defined values and maps larger status values to
> failure.
>
> 6/7 rejects 'unknown' as an action. The action table contains it at index
> zero, but the options attribute advertises only 'start' and 'stop'.
>
> A previous result can also hide a new calibration attempt:
>
> failure -> start -> failure
>
> The status appears unchanged for the whole operation. 7/7 clears the
> selected status to unknown before submitting a Start. Stop leaves the
> status unchanged.
>
> I built every patch against kernel 7.2.1-ogc3.1.fc44.x86_64 with
> W=3D1 and KCFLAGS=3D-Werror. I tested the exact final module on an Origin=
al
> Legion Go. The configuration interface bound without a kernel fault.
> An idle Stop result of 0x08 was reported as failure. Writing 'unknown'
> returned -EINVAL without an output report or status change. A later Start
> produced failure -> unknown -> failure; the final report contained result
> 0x02 and error 0x0007. The five unselected statuses stayed unchanged.

For the series:
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>

Jiri,
Aditya didn't tag stable in Cc for the fixes tags, do you mind adding
that when you pull?

Thanks,
Derek

> ---
> Changes in v3:
> - Initialize command completion state before hid_hw_start() and
>   hid_hw_open().
> - Remove the unreachable zero-length calibration action path after
>   rejecting 'unknown'.
>
> v2 review:
> https://lore.kernel.org/all/CAFqHKTnQiTQc6joz-Y6tmjR=3DC5giF-MuHeBwu3rw+b=
mFVMQtqw@mail.gmail.com/
>
> v2:
> https://lore.kernel.org/all/cover.1788096666.git.mradityadash@gmail.com/
>
> Changes in v2:
> - Drop the FPS DPI patch; the existing request is correct.
> - Drop the v1 Boolean calibration-result mapping. Preserve values 0x00
>   through 0x02 and map only larger failure values.
> - Move the existing pending command state into the driver data and
>   initialize it in cfg_probe().
> - Use scoped IRQ-save guards and validate the report size and ID together=
.
> - Drop the v1 no-wait calibration path. Correct requests receive their
>   matching SET replies within the existing 50 ms timeout.
> - Reject 'unknown' and clear only the selected status on Start.
>
> v1:
> https://lore.kernel.org/all/20260821214810.87826-1-mradityadash@gmail.com=
/
>
>
> Aditya Dash (7):
>   HID: hid-lenovo-go: use the correct calibration commands
>   HID: hid-lenovo-go: use the right controller selectors
>   HID: hid-lenovo-go: initialize command completion before hardware
>   HID: hid-lenovo-go: return configuration request errors
>   HID: hid-lenovo-go: normalize calibration failure status
>   HID: hid-lenovo-go: reject unknown calibration action
>   HID: hid-lenovo-go: clear calibration status on start
>
>  drivers/hid/hid-lenovo-go.c | 191 +++++++++++++++++++++++++++---------
>  1 file changed, 142 insertions(+), 49 deletions(-)
>
>
> base-commit: 1292bca0f8d835d2ad96d309595b2e97f3106d3d
> --
> 2.55.0
>
