Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59433BCD3C;
	Fri, 24 Jul 2026 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893391; cv=none; b=G0Up1r+inpUQsJJJGlsqbdfeOGrIQthhC/sX61oc4W8P/7vwv28V7eVJUO5rsuivJ3/JslO9kxSTYdShhdvw2T0AUOVWsxtVV6Y6Xw7jiZK9ZbkFAJ1RyO3YmgWLEXuC4ckAxnxFZzgD1+nJdeWH+PTHuq4kabR1tFt+IhEwo3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893391; c=relaxed/simple;
	bh=AQBG8v7VRajQ7mOhtZ1bRu49h9mupAcTjQ2qUqQj8uw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pMuvJnKacDHV8OUnE7/cbdvhEu5Zl9Md1rJvBoDjCLzPMciOLMSyQZJh1JJD9WRdnW97VbiPtymr55qdM99fSiWKVjtpGIRZaLZRRGS6kDmTvfcpV3WB++aN+56F4YhHx402bjp11BDhP9yUpPa2vmU4c1sqy4Tf1rliiVUKZyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTS1sW74; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTS1sW74"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784893386; x=1816429386;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AQBG8v7VRajQ7mOhtZ1bRu49h9mupAcTjQ2qUqQj8uw=;
  b=CTS1sW74uYI1SM8rGTr8I60ryY5LeGPJuxHfzDYfjxuXn1kWE2WUgPhv
   hzmUilxGyg7WKnTJ4B5HMzQta4SI+J5Z0YWwGlsP+W2I/0LAzGoEwMvD6
   P6I81iyZ2aIm3/KJydzGkAw/qKCMLyFpgcgYDCwv39OxBN6hR9c79FEpa
   6LSHKP2fgsECZJeW8OanRn/ikBSxjBBuClDp3uIsiW9HdYYbzmX3w9YMM
   2cFGF4q79CDUGK3/MGXuP3FmjNp8TF7ZhuL0MlCHG4505Bo/BwYRnToUM
   tvtRIttOy0xUqa2Q9U8BjqbmyH3jL+9CoBpUYwrRCZyfjKjeiREenBc9d
   A==;
X-CSE-ConnectionGUID: 3LmiewalTtyZYQBPm6iQmA==
X-CSE-MsgGUID: bNKICO2jSNGoBpvTUb/qQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="97073380"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="97073380"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 04:43:00 -0700
X-CSE-ConnectionGUID: f1QjFXFxSqauqntoRyycfQ==
X-CSE-MsgGUID: CkM4k/XETrajpzPHlYA8PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="256916870"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.8])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 04:42:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 24 Jul 2026 14:42:52 +0300 (EEST)
To: Dave Carey <carvsdriver@gmail.com>
cc: platform-driver-x86@vger.kernel.org, hdegoede@redhat.com, W_Armin@gmx.de, 
    jikos@kernel.org, linux-input@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 0/2] Lenovo Yoga Book 9 keyboard dock detection
In-Reply-To: <20260722201659.874469-1-carvsdriver@gmail.com>
Message-ID: <10e5c25d-7fc8-5db8-e8d3-b76c5d413acd@linux.intel.com>
References: <20260722201659.874469-1-carvsdriver@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-914480921-1784893372=:1365"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-914480921-1784893372=:1365
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 22 Jul 2026, Dave Carey wrote:

> Changes in v14 (addressing Ilpo J=C3=A4rvinen's v13 review of patch 2/2):
>=20
>   - Restore #include <linux/compiler_attributes.h> and <linux/spinlock.h>=
,
>     which were accidentally absent from v13.
>   - Restore spinlock_t lock in struct yb9_kbdock_data, spin_lock_init(),
>     and spin_lock/spin_unlock around input_report_switch + input_sync
>     in yb9_kbdock_report().
>   - Restore pointer-out yb9_kbdock_query(d, u32 *bkbd) and removal of
>     zero-initializer from struct wmi_buffer out.
>   - Restore int return from yb9_kbdock_sync() and error propagation in
>     yb9_kbdock_resume() and yb9_kbdock_block_probe().

Hi,

Unfortunately, this still seems to miss one non-cosmetic change (diff of=20
diffs, v12 vs v14):

diff --git a/drivers/platform/x86/lenovo/yb9-kbdock.c b/drivers/platform/x8=
6/lenovo/yb9>
 new file mode 100644
-index 0000000..0000000
+index 0000000..40a2566
 --- /dev/null
 +++ b/drivers/platform/x86/lenovo/yb9-kbdock.c
-@@ -0,0 +1,322 @@
+@@ -0,0 +1,324 @@
 +// SPDX-License-Identifier: GPL-2.0-or-later
 +/*
 + * Lenovo Yoga Book 9 keyboard-dock detection
@@ -421,8 +449,10 @@
 +      /*
 +       * _WED(0xEB) returns EC.BKBD directly as a 32-bit integer
 +       * (LENOVO_BTKBD_EVENT WmiDataId(1) uint32 Status).
-+       * Short-buffer guard is handled by .min_event_size below.
 +       */
++      if (!data || data->length < sizeof(__le32))
++              return;
++
 +      u32 bkbd =3D le32_to_cpu(*(const __le32 *)data->data);
 +
 +      blocking_notifier_call_chain(&yb9_kbdock_chain_head, bkbd, NULL);
@@ -441,7 +471,6 @@
 +      .id_table       =3D yb9_kbdock_event_id_table,
 +      .no_singleton   =3D true,
 +      .notify_new     =3D yb9_kbdock_notify_new,
-+      .min_event_size =3D sizeof(__le32),
 +};
 +
 +/* ------------------------------------------------------------------


> Changes in v13:

[...snip...]

> Changes in v10 (addressing Armin Wolf's v9 review of patch 2/2):

[...snip...]

>   - yb9_kbdock_notify_new(): drop manual length check; use
>     .min_event_size =3D sizeof(__le32) in struct wmi_driver instead
>=20
> Patch 1/2 (lenovo-ymc) is unchanged from v9.


=2E..And there's no need to apologize. :-)


I personally keep earlier versions of the patches I've sent myself around=
=20
as files so I can easily do diff-of-diffs against the previous version. It=
=20
has saved me sooo many time from making fool of myself.

I actually normally write the patch version history bullets based on that=
=20
diff so I won't forget anything important from it. Nor hallucinate some=20
changes that I thought I'd made but didn't (=3D> back to the drawing board)=
=2E


If you need the old version you can probably get them from lore archive if=
=20
you don't have them around anymore (but by not placing them cleanly into=20
own threads one needs to be careful to get the right ones).

--=20
 i.

--8323328-914480921-1784893372=:1365--
