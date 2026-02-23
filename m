Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B955237F8C0
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 23:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889374; cv=pass; b=Bi0eH5HeIwhhfW61LMMZY3CVBHgTH/v0jPmCbGals0PaQfJIPxhJPuJZA7MyjceTkLMn6Gvn2fF807zQv+zjvcH4Dgi9Wrs1aBGIhFynPqIGiZ6hOd24h35IU0RkGnfU32KeZVbYidmtbc2hQF6khlzpgLzL8S+9+o0VGbKdCCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889374; c=relaxed/simple;
	bh=J6zBSnuv2VUk6bsTnE+sg32kVJnVvTzg2RryFVDgAJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyBQMEkynLMoA43TW8HdC/WapanLGGNf08jEZdQtIise0l7NiQROfo8exD+4AJWL0cWhAgsp+MRzZT4JD0ol+WF8OF4KY1U+BLvdxBpuADuY7YdYQDNZ4umSbDMiuN1PyU5FeLYKkNt4IyqInBmGf9PNzJ1gAet6rFHrxnpFAvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nevCftR9; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nevCftR9"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3870cbd6c40so43609851fa.0
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 15:29:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771889371; cv=none;
        d=google.com; s=arc-20240605;
        b=cO1G7HxXR1LfUDgI3okjmACv5Te8uLUZ9LeM5fBhouHp7u51VHBOtkgZJiKWpBOt72
         tcMUxXqSmhTuOtNeNuZxXHxqsfTJiLhvmBE+V3rKjvp8JTVlTrsRRrdx6CvNguXN3zB1
         taQju3kOqEi56CzmccIrSi1zuysZ1zB8x37RxjjeBhvmRO2oQQx4FQoO+k9IbYvol0qi
         /THZ97P4FzObWtOaWAfpndnZg0JGu8yjKVrSfH9Y3JkOkmZ6PbR1gIcykq6VfkDqgZcf
         Z4ifQZDrOVtiLMdIV3eRqjDYf7DCfu2zH7GSUdy19g1v+6OBbEf74Sv2/MlBrWeB06aM
         nS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8WfeWRTrku2bTr2EuWBQJnzZIlU4RzO3uGEG8JLabpE=;
        fh=uSxVFp7UfFc1abB10AS7qvQg/mZgVU6yjVyL2oyfx40=;
        b=NOWE5N4pvghK6PrN8RhdUmTS2x/tbAmb4qaxRwDuqQSWDnvNsakRh3NudMQOkT6PW7
         jtvOTxACoQ73Pff2iqAYJRPe7ZOxxtOCsAgL8KA5BFCXkR4WgkexBNQtN7VA+6jJZBTQ
         DZPnGqJxgKdyyfJ6kHhf3NAmmUVhG/mrXoKjUu9lilUCwEL3Fa/hTqz4MX9hVznCVTU1
         fwD4dRgfrwcuBfcTr5KATAl5DHh+uPJHlqTC6iE/ZHWF/O9StEJTUpyLQLN6gsnD8ujn
         WXllGPgS/MfE3HbrZBPmIMvBNBRi5J6+oAPffrinj4hC7AqA+N/daKqR+hR+0BTdjnrP
         lafw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771889371; x=1772494171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WfeWRTrku2bTr2EuWBQJnzZIlU4RzO3uGEG8JLabpE=;
        b=nevCftR9AcRWGqYXWI1CDNO1KT1FavHDqplGfOdrQb0TohoQ+k1wd3vOxTBAvAlyJC
         tctF1YKqAQZzPABDHpC3Wq2cDvUOMrpa0ojmKtAFDX+9sUWrBgNFOs66mYFmvxRB/+sj
         2TMzAFFNsVscY+aHVp8lnOA1tSBqSUN0BJAPG3YoLoK2f1BQhmGEZrD7fYGc1qF/1h8o
         GwwTzzsIb3iBosONx0fA5jD+gFh6e/pQKAHFzKcFzXw5zEe/VrYaElIWJ8s6C1lgtVQb
         F7ruXjWis8DvjzYLlwV0vshL87NkxsGEm5Wt3cZUBYUhjFSQivzlD+q1B2aGCqWO9FZh
         JgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771889371; x=1772494171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8WfeWRTrku2bTr2EuWBQJnzZIlU4RzO3uGEG8JLabpE=;
        b=fWDTjUxA+/gHUfrcRDXw5Hlgb0i965UBcg7lVX9JVT44DQ2Vv5zLNVtG/rmZ02yM1K
         GggEfrjwa3IUDuYNJbbCLHYeF4RkdEWzU1KtRtQ/vIWl/AJ3+nWmduD+So/79e+ao1yH
         e1EQIlm7s5g3QtCiQPYibeOH06MZqa8yEa1S+HpB24MXwF4HP/slYFm4TzTXHDq5ihLz
         IkBZ+B4vXF/s1jlYmCwZNqPYyJt8uFTZ5VNgwGssXten11SGmhtaWy7KMK3KTs7bFTjY
         QGRVXi/b/JnQYvQ5v15XTBvk2D27/4HEdhyPcd1fXe11rXo5Y9PWYjp25gf3gm20DgWw
         o78w==
X-Gm-Message-State: AOJu0YzADBl9Uad/oMky/E86YbJJSuwh+JGrwbsfWia92Lygwc8a8/6R
	F6dhU8It62vh5Y/4gMvPW21XHBKQHY+MXAbfN4AzB8JPVcrGft/l4SMo95tzUCHagXaXuPgg+q1
	+AbmRpdHvEcuDM9r+dQ6wJqr/2NtFAUQ=
X-Gm-Gg: ATEYQzx0bF+LHkNkPG9RCSXIctYTGNj1eUx5HEh/RhKTnPsVhwaXjb+ukD/dULv+CXR
	ZKXxYNUC8PlBwmG6R3ie2A4KJ3UCj/JbAD8zgw0xmDt4pv/uMtirmWFI62Q2jyuQdQ8VP6L0/Pc
	7ybpzURXs5C1owlqvIeFui9JUR3IZlQkwmE4ofTmLh8BhQ6mhhodyeZ7ex33D9dUKTgTWOQCU5/
	Aolz7dJamDqqVrbsTwB8hOKc2l7SrQFKntJkend5f/mcB6FlJKrgz5kaNQDjbCxKngQIzQTFj1Z
	rBvq3IxjlKePYDk35w==
X-Received: by 2002:a05:651c:31cb:b0:383:2537:f121 with SMTP id
 38308e7fff4ca-389a5dae7a4mr30229781fa.26.1771889370676; Mon, 23 Feb 2026
 15:29:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209063355.491189-1-vishnuocv@gmail.com>
In-Reply-To: <20260209063355.491189-1-vishnuocv@gmail.com>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Tue, 24 Feb 2026 08:28:51 +0900
X-Gm-Features: AaiRm52DBKb5bl7l5Bo_mvwDqKR1GnB0ZMS9OrdzJgEL0ePOj09NuELgOXAuIX4
Message-ID: <CABxCQKvNO78SeVp9pAnBOSAF=x0eFn03F33ftW-x-rZCG0-84Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] TrackPoint doubletap enablement and user control
To: mpearson-lenovo@squebb.ca, dmitry.torokhov@gmail.com, hmh@hmh.eng.br, 
	hansg@kernel.org, corbet@lwn.net, derekjohn.clark@gmail.com, 
	ilpo.jarvinen@linux.intel.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ibm-acpi-devel@lists.sourceforge.net, linux-doc@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, vsankar@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Gentle ping on this series.

This is v7 addressing all previous review comments.
Please let me know if any further changes are needed.

Thanks,
Vishnu


On Mon, Feb 9, 2026 at 3:34=E2=80=AFPM Vishnu Sankar <vishnuocv@gmail.com> =
wrote:
>
> This patch series adds support for TrackPoint doubletap with a clear and
> simple separation of responsibilities between drivers:
>
> 1. Firmware enablement (trackpoint.c):
>    Automatically enables doubletap on capable hardware during device
>    detection.
>
> 2. User control (thinkpad_acpi.c):
>    Provides a sysfs interface to enable or disable delivery of doubletap
>    events to userspace.
>
> The approach follows the KISS principle:
> - The TrackPoint driver enables hardware functionality by default.
> - The thinkpad_acpi driver controls whether ACPI doubletap events are
>   delivered, using existing hotkey filtering infrastructure.
> - No cross-driver APIs or dual filtering paths are introduced.
>
> Changes in v7:
> - Removed unwanted comments and logs
>
> Changes in v6:
> - Documentation: fix formatting of the doubletap_enable sysfs attribute
>   description (separate "Values" list)
>
> Changes in v5:
> - Rename sysfs attribute from doubletap_filter to doubletap_enable to
>   reflect actual behavior.
> - Fix inverted logic so events are delivered only when doubletap is
>   enabled.
> - Suppress ACPI hotkey delivery instead of injecting or filtering input
>   events.
> - Register the sysfs attribute via hotkey_attributes[] instead of
>   device_create_file().
> - Drop unnecessary helper wrappers and debug logging.
> - Update Documentation to reflect the new naming and semantics.
>
> Changes in v4:
> - Complete redesign based on reviewer feedback.
> - trackpoint.c: Simplified to only enable doubletap by default.
> - trackpoint.c: Removed all sysfs attributes and global variables.
> - trackpoint.c: Uses firmware ID detection with deny list.
> - thinkpad_acpi.c: Added sysfs interface for kernel-level event control.
> - thinkpad_acpi.c: No cross-driver dependencies.
> - Documentation: Updated to reflect simplified sysfs approach.
>
> Changes in v3:
> - No changes.
>
> Changes in v2:
> - Improved commit messages.
> - Removed unnecessary comments and debug messages.
> - Switched to strstarts() usage.
> - Simplified firmware capability detection logic.
>
> This version addresses the remaining review feedback by correcting the
> naming and logic inversion, aligning sysfs semantics with behavior, and
> fully integrating with existing thinkpad_acpi hotkey handling.
>
> Vishnu Sankar (3):
>   input: trackpoint - Enable doubletap by default on capable devices
>   platform/x86: thinkpad_acpi: Add sysfs control for TrackPoint
>     double-tap
>   Documentation: thinkpad-acpi - Document doubletap_enable attribute
>
>  .../admin-guide/laptops/thinkpad-acpi.rst     | 21 +++++++++
>  drivers/input/mouse/trackpoint.c              | 45 +++++++++++++++++++
>  drivers/input/mouse/trackpoint.h              |  5 +++
>  drivers/platform/x86/lenovo/thinkpad_acpi.c   | 42 ++++++++++++++---
>  4 files changed, 106 insertions(+), 7 deletions(-)
>
> --
> 2.51.0
>


--

Regards,

      Vishnu Sankar
