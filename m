Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27423A5E78
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784877162; cv=pass; b=FdsG0BnfzTK0smAtd4+y0v4VnJOJZ4r3kmqkVa0Q7UelR14yD+WnS7e1K48z5aUo7jbcoB0IjAAlPiQQrmq/BMwWjbFg2kPaiCeamQpMeCX+ebD3GjcY5ZDq3OAn5uz3n12fGLJCUUueXSKt0MGX1qKzSxqxIZ/kRA07bBIT3Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784877162; c=relaxed/simple;
	bh=xGUvizPuVEq9S/D//hkOZzPE/Y56rvO9KY90rU8622g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BELXjgNqkZ5KmtgnJC2sNOQLLsR/THWAXTNSRiiUOT6cZ31b4aAqX2WE9CS7WZYPuRXjmGbqmz0zgjVQpWoqsJzFkiO07kn6STOhFqy71nEU0jAwOgRGHGKZv46rkeMLduyG3H+TvmIrnjwvr5nt+QLC26ZEFIGO24SyXYMlM2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbcdqQCt; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbcdqQCt"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51ca592e80eso223361cf.2
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 00:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784877160; cv=none;
        d=google.com; s=arc-20260327;
        b=peXEUbUQjy1AIaD+Kv4RQU6SOXO3knZopmOge/ZGtglfALbk8eKNg8y5D6ucpP5GT3
         GIE1yi6DudY6d3MKs4iOZM1a3aTAY/Ow1QDVpr/H6qanJgKO0oNEqB414lRz5d/ejoOB
         pW25yp//AcQXH+zdloFfbCNPBuxd8Rwt6GJeT53cJhiEXlK2WN8XVWuNtHuKEaeNlqjm
         biyjLyhWZyk9hRaqTNqm13F7svRg/9mXKn0MMCtLoVhErhkO1Vb3eIToMoNFbkHSCx2T
         WrpJzt7AHSbRl6C+gUEwDtvkYda8yYUiZhRVZEVGx+hhyW+fa/CrM7XkueOpv1hHKUQ0
         wllQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=IC1GTb3TLPTeqAoieueA9lJNkRWp5M+M/cNZOJoVguk=;
        fh=J2MgbrkXlDlqcGlDple96bRjx/dtzTfq8U5OsiFxhCs=;
        b=RZv4OGXeN4D1ldoCPhdCQU+w72SfU69B9V5ch2W3tkPev60kGP/qRvbZkiyczKXM5T
         6imJ9yo9043W346kvAsT6xV6yxCchTttP2HMpN/ztN4vDRVlln3OutGh56sHv8UXu9Y6
         1zxlAu7ld+EQxsuNZxIlCwy2onlhdqdcrBObYOv86YW3B+jfnIEgyMi1kwXJ6VZxtMeL
         pfba6KgxW+c3ri9Qu+kcclj6J/YL62b6qyhiVMFcT9/rnf9unjLdwWwXnEnxqZi2UMyg
         VwD3M4KxBucujXMMohvvZtYEc9z4SLfQW69rhF6o9LwCV3fexfMCOaz+x7xR/lyTt879
         I71Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784877160; x=1785481960; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IC1GTb3TLPTeqAoieueA9lJNkRWp5M+M/cNZOJoVguk=;
        b=EbcdqQCtjg1WgoH3noeyFMHyHeQp7NKEj/FP59C/d4R8MEwDtHma5KslxQv/d2p9AK
         uBh+gx9fJ6gKN1978yHo46zGQRBJbt0QIieQrAL4Q3qtZQA/9A8I5e+RvQa94b1FJcxU
         6ePG1+Hs+eH7ZjrhBzFNwylLGI7AyF5cJk8KPpu9vfMELaOA0wPa2BBqnRVcA98RwtxJ
         BddBUqWcBHM5/nMBbiY1ca/DrBsftjLoofgn91sWv3MWl/0Cjts8DJGxqnOZyfbgQ/7+
         tbO6M4rg3Wt0z5yZjuKw0KlziB1y5udoL3+rrC2m+Kg/o60B2RmmamU2MsuprjkdOo8N
         Oj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784877160; x=1785481960;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IC1GTb3TLPTeqAoieueA9lJNkRWp5M+M/cNZOJoVguk=;
        b=tQ/V3HuNENJoyZXIBd4E9iUw8ondaI+YzhXM5Cv7MoWGYSG1Gh9rmjwtVPnzzhinm0
         rbF967K8BB8b6E4jXyUQfqQSUuHQemstszo7S276EtFWin87P5s0QPhsOIpHGFwDRfxG
         Vbu/i5rboicEVumK11W9ztHGxtyhCarcTSK4g0qkkoX3D4IAONPdXWdlPKM034L4oYPF
         3F3kbnu0OdfbbXUbD3kFYYR63O9H+UW6RHpFfyacO5wGAXGfqXgmvFtmIZ0b1aLdtfvh
         rxU/DPeis4iNRrTi5jAs5fjWdrYTm9fdCGiHYam9N4Uu73poQti4wA5Fy8kTQLmr3QDD
         aLpQ==
X-Gm-Message-State: AOJu0YxDTvNNvmgfRS0tdOHlY89CIGjuCC7tamtyPunm5laloHlZ7Fqd
	kuMJ4ergf/ojExE8bVn9iO8guC5p4hkgLMbqCfrb/cfO3k6nlAWPXSt0v64o1oitP3ytM4YnpWu
	QyK6bBZg+x6c6aoajiDouxf4hWQQm/cM=
X-Gm-Gg: AR+sD11Xpn3Nc7bgfk24mil96eRRbV6SdT5Ti5dI1rIZfmDhSim3UcoFfD4zR1gEJUN
	4FSb9Uxvo0a2wWzVud49J4IDkINW9qEce8qMynL2Z7HY/n6ALUwfB/VtBZcD+oyuBOCbB8bfMlX
	rYlnHtaehOQ7XAlDoa0JOvtdj1z0LNJzl+n7a8MJdwar4XsactBFhEwcQnpw56b74ZTqnQH2lfF
	r6Yq1M8zDuoglI360hvVPajCFMfmgP9zehlqwoumbhZ18BVYgZTWdP+i5er04KWnVrXa8RHofnp
	Jdhi0gYCRlP3Qq6TrCp0scUjIPvR7xZEfRYoMXPJ/S7fcPbjUsrlz14Iuype+WlwaNfRHcfIpNW
	J0AjBo9WP9kbWLKSi
X-Received: by 2002:ac8:7fc1:0:b0:51b:ff78:f229 with SMTP id
 d75a77b69052e-528497b70cbmr22473281cf.5.1784877159685; Fri, 24 Jul 2026
 00:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniel Paul Perinchery <danielpaulperinchery07012005@gmail.com>
Date: Fri, 24 Jul 2026 12:42:29 +0530
X-Gm-Features: AUfX_mx8H9gltbQgDBIO4d85xHHxI01kSyYqQrP-Ki9e9wjpNV70u7MN3JR24xM
Message-ID: <CA+8Hp=M3ynUHzcDshLup5G+HDs0XoWkav0R5k-00m+O7LbOv1w@mail.gmail.com>
Subject: hid-sensor-custom: async notification for input-report sysfs
 attributes? (human presence / attention sensors)
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I've been investigating why userspace can't efficiently watch a
hid-sensor-custom input-report value (specifically a human-presence
sensor, HID usage 2000e1, on an AMD Sensor Fusion Hub / amd_sfh
platform) for changes without polling, and wanted to check whether
there's interest in closing this gap before I try to write anything.

Setup: Lenovo IdeaPad Pro 5 14AKP10, AMD Ryzen AI 7 350, kernel 7.0.13
(Debian/Parrot, but this is stock hid-sensor-custom.c). Presence and
gaze/attention are exposed as separate logical sensors under the same
physical hub (HID-SENSOR-2000e1.x.auto), each with the usual
auto-generated input-N-<usage>-value sysfs attribute.

What I found tracing show_value() in hid-sensor-custom.c: for input
reports, it calls sensor_hub_input_attr_get_raw_value(..., report_id,
SENSOR_HUB_SYNC, false) -- i.e. every read of the -value file issues a
synchronous GET_REPORT to the hub and returns the live answer. There's
no cached field backing that attribute, so there's nothing for a
notify-on-change mechanism to attach to on that path.

Separately, hid_sensor_capture_sample() *is* a genuine async callback
fired on hub-pushed input reports, but as far as I can tell it only
feeds the raw kfifo behind the driver's misc-device streaming
interface (custom_dev), gated on test_bit(0,
&sensor_inst->misc_opened). It doesn't appear to update any per-field
cached value, so it isn't reachable from the sysfs show_value() path
either.

Net effect: there's no way for a userspace consumer to poll()/
select() on the -value file and be woken only on real hardware events.
The hub itself is already configured for threshold-based reporting
(property-reporting-state = 2, i.e. "Threshold Events") in my case, so
the inefficiency is entirely on the kernel/sysfs side -- userspace has
to fall back to timed re-reads of a synchronous, firmware-round-trip
attribute, which is more expensive per-read than a typical cached
sysfs value and awkward to size a safe polling interval for.

This seems like a real gap for the presence/proximity use case
specifically (walk-away lock, auto-dim, etc.), which is inherently
event-oriented and is exactly the kind of feature vendors implement
natively on Windows via push notifications from the same class of
sensor.

Before I put together a patch I wanted to ask: is there interest in
adding async caching + sysfs_notify() (or sysfs_notify_dirent(), if
attrs end up carrying a stored kernfs_node) for input-report values
specifically, sourced from hid_sensor_capture_sample()'s existing
async path? Rough shape as I see it:

  - add a cached "last input value" (+ a bool "valid") per relevant
field in struct hid_sensor_custom_field
  - in hid_sensor_capture_sample(), in addition to (or instead of,
behind a config/attr) feeding the misc-device fifo, decode and store
the value for the matching field, then sysfs_notify() its -value
attribute
  - leave show_value()'s SENSOR_HUB_SYNC path untouched for feature
reports and for any input attrs that never get an async report, so
nothing regresses for existing consumers

Happy to be told this already exists via a different interface I've
missed (I did look at whether this should just go through the IIO
buffered/trigger interface instead, given some other hid-sensor-*
drivers are IIO-backed -- but hid-sensor-custom exposes vendor/custom
usages directly via this sysfs shape rather than IIO channels, so I
wasn't sure that's the right layer to add it at). Also open to being
told the misc-device/fifo interface is meant to be the async
consumption path already and userspace tools should be using that
instead of polling -value -- if so, is there existing tooling/docs for
that path I should be pointing presence-detection use cases at?

Not attaching a patch yet since I'd rather get a read on the right
approach (and whether it's wanted at all) before writing one.

Thanks,
Daniel Paul
