Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E4F358378;
	Mon,  3 Aug 2026 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775383; cv=none; b=DfeJCrMktfWkKhydZKpT4p1+EgoKvWI8pu3tv2SbivYv1ehDQU+qg99qGkAoS4lJx+ukxwgwBGgn0SYXV/eaBfUp0efEY/weTcsJ9d+15+ifDKWKBf6SHpxPKx8bn/BGz1V9rJVyxoeYsO0G+tD10eLNTFSFlfOaf5TdqhG9sHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775383; c=relaxed/simple;
	bh=3NDkwT9awZYfvoORE0bau45fdFFCeYi5IA5RKptQ3NE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=a4pLHPA4kpI67Z8MmJZuEo7UenstQGXbg945Npwr8svLBHOHqmMiuMqxV7fCIIVwrgjBM2pGaJB1XcFSktj1hwYlaDZQq+2mTwxS42c9eWe7olMBRSJLU9Y2WEFSov5GfQfCvCOPWZiI+H3DLSheT0dUAvNJcHot0lit3cjINeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DAJQT1+u; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DAJQT1+u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785775381; x=1817311381;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=3NDkwT9awZYfvoORE0bau45fdFFCeYi5IA5RKptQ3NE=;
  b=DAJQT1+u6/rooRqUJ2w6f99t7oNVzQ5wL8belZIFucI7MGBpgQ2TlQBq
   2hnszrIJ4ACh7iRa4MtVevrgwWW6nLPm4/6SMsAaYjsKIgNq/RTNsFxqq
   hOGMdviuyuVUkS1qtPQX5IMmu25fYJbwx6zusKne1if3wQkhGcqX4YcHO
   hlsvZffl6noxPhzqMn1C0ZXpxH60Q94rrA62TPJx7NyCJ9owDs9NndGDd
   R9qM/DcuONGjd5L3Q9fyobcx4CANAV8yZwFmo2O+o3ZHdS54erKQSZD8O
   63rRz41yemrPiJY5dUtAKs34rwgw6uGpwqcS6jS/kDGO6cwAbEHAViMsA
   g==;
X-CSE-ConnectionGUID: uQPDeMThTEG5Y6MQv18Tig==
X-CSE-MsgGUID: BmxOz/WrQ1yxXtjT/d8WcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86264780"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="86264780"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 09:43:01 -0700
X-CSE-ConnectionGUID: GYKq5WwQTsCGfGOzoLiu0g==
X-CSE-MsgGUID: f7298wewSpWE3SqXsJKqBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="299487689"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 09:42:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 3 Aug 2026 19:42:54 +0300 (EEST)
To: Dave Carey <carvsdriver@gmail.com>
cc: platform-driver-x86@vger.kernel.org, hdegoede@redhat.com, W_Armin@gmx.de, 
    jikos@kernel.org, linux-input@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v15 0/2] Lenovo Yoga Book 9 keyboard dock detection
In-Reply-To: <20260728225545.1333610-1-carvsdriver@gmail.com>
Message-ID: <369a1d84-f6a2-1075-b62e-c1852ae25894@linux.intel.com>
References: <20260728225545.1333610-1-carvsdriver@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-134009376-1785774538=:1172"
Content-ID: <a0a78e8b-56a6-cf99-0eaa-fcf22e5d6568@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-134009376-1785774538=:1172
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <0e9fcf9e-64a6-1deb-87a9-b869e4dac184@linux.intel.com>

On Tue, 28 Jul 2026, Dave Carey wrote:

> Changes in v15 (addressing Ilpo J=E4rvinen's v14 review of patch 2/2):
>=20
>   - yb9_kbdock_notify_new(): restore .min_event_size =3D sizeof(__le32) i=
n
>     struct wmi_driver and remove the manual buffer-length check; the
>     .min_event_size field was present in v12/v13 (added in v10) but was
>     accidentally dropped in v14.
>=20
> Patch 1/2 (lenovo-ymc) is unchanged from v10.

Thanks for all the effort. I've now applied this to the review-ilpo-next=20
branch with Hans' reviewed by tag reinstanted as that too seemed to have=20
gotten lost.

--
 i.

> Changes in v14 (addressing Ilpo J=E4rvinen's v13 review of patch 2/2):
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
>=20
> Changes in v13:
>=20
>   - Resend of v12: v12 was corrupted in transit.  Root cause: the ABI
>     documentation uses RST table separator lines (=3D=3D  =3D=3D=3D=3D...=
) which
>     contain '=3D' characters; git-send-email selected quoted-printable
>     transfer encoding due to non-ASCII in the changelog (UTF-8 author
>     name), encoding '=3D' as '=3D3D' and breaking git-am on the receiving
>     end.  Fixed by setting sendemail.transferEncoding=3D8bit.  No content
>     changes from v12.
>=20
> Changes in v12 (addressing Ilpo J=E4rvinen's v11 review of patch 2/2):
>=20
>   - Add #include <linux/sysfs.h> (for sysfs_emit)
>   - Add #include <linux/types.h> (for __le32 and __packed)
>=20
> Changes in v11 (addressing Armin Wolf's v10 review of patch 2/2):
>=20
>   - ABI doc: correct Date to "June 2027" and KernelVersion to "7.3";
>     these fields should reflect when the ABI lands in the kernel, not
>     the submission date.
>=20
> Patch 1/2 (lenovo-ymc) is unchanged from v10.
>=20
> Changes in v10 (addressing Armin Wolf's v9 review of patch 2/2):
>=20
>   - Update ABI doc: Date: June 2026, KernelVersion: 6.16
>   - Add #include <linux/compiler_attributes.h> and <linux/types.h>
>   - yb9_kbdock_query(): change return to pointer-out u32 *bkbd to avoid
>     a 0xFFFFFFFF status value being misread as -EPERM
>   - struct yb9_kbdock_data: add spinlock_t lock
>   - yb9_kbdock_report(): hold lock across input_report_switch + input_syn=
c
>   - yb9_kbdock_sync(): return int, propagate query error to callers
>   - yb9_kbdock_resume(), yb9_kbdock_block_probe(): propagate sync error
>   - struct wmi_buffer out: remove zero-initializer (not needed)
>   - yb9_kbdock_notify_new(): drop manual length check; use
>     .min_event_size =3D sizeof(__le32) in struct wmi_driver instead
>=20
> Patch 1/2 (lenovo-ymc) is unchanged from v9.
>=20
> Dave Carey (2):
>   platform/x86/lenovo: lenovo-ymc: Suppress probe on Yoga Book 9 14IAH10
>   platform/x86/lenovo: Add Yoga Book 9 keyboard dock detection driver
>=20
>  Documentation/ABI/testing/sysfs-driver-lenovo-yb9-kbdock |  19 ++
>  MAINTAINERS                                               |   7 +
>  drivers/platform/x86/lenovo/Kconfig                       |  14 +
>  drivers/platform/x86/lenovo/Makefile                      |   1 +
>  drivers/platform/x86/lenovo/yb9-kbdock.c                  | 323 ++++++++=
++++
>  drivers/platform/x86/lenovo/ymc.c                         |  19 ++
>  6 files changed, 383 insertions(+)
>=20
> 2.55.0
>=20

--=20
 i.
--8323328-134009376-1785774538=:1172--
