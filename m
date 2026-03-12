Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E9F3F87E4;
	Thu, 12 Mar 2026 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336895; cv=none; b=SmVpJsZPtSOIaJAxr4QsnJ4DipoGHJEgZtlx/Vz8KGH0MNAeK0I1y9KRXViPxmHMBk6Nl+B99wgeL8a0jR0TO2uTKivO0cIrireheGR5/8Q2imD/Ko04BJZksWRThIDA0XgA8LL7wbyKhrIWJwRMFDFuUqZuBkYT0RpkPPcH59c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336895; c=relaxed/simple;
	bh=GjRSZPtRoadRciRerMC+6uH9xrPzzmTmrc3rFGwVbmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pL/h6WhlDUZkXwFY7Cbnr9KrVbtEYbjIFWpmBE8k3d6mKXBnFTBUrgAGeT2Ao/jzLUhXPZLUP0SnJOjpbKymgQVYB1USo0ZWE8iRFuuM9BpE823dq8m23ZeUvDianJdXLma/274ANVX2hOPdoPB/JvpXGohW/o1Q/RIss/qD80U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUxZ/Gsp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUxZ/Gsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71ECFC4CEF7;
	Thu, 12 Mar 2026 17:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773336895;
	bh=GjRSZPtRoadRciRerMC+6uH9xrPzzmTmrc3rFGwVbmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tUxZ/Gsp4PlAe6XQp00WrN6u5NVHCExCnFbCopQQf87UnDRpSOAGyvAn9n2hFrX/c
	 L74wn+3QWnDiV9I+po0Acr95nZp0xGBEb2PdcA/48RxEkg9L7NeVBYVkoGXwo4oztA
	 v+vQtKdAEO/474D3JpD9F35FuR10pokM9qC4XMrmgi13Lt8nFiepB+oPZqimOYx5W6
	 MB4FzIp0mLgbb+fH1z0dixP/O4Vvk1xlE3X0NvrfW0hJwlDKjJzNk9qjbe3Nk+fPRL
	 jJ6J1qFt4dFXMz/HCXUWyhKu+GDVhgEYOwwdONgVXP80q+gso+Ys07A1STyekPOeGg
	 E6+DzWduwuPwQ==
Date: Thu, 12 Mar 2026 18:34:15 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [tip:timers/vdso 37/45] progs/hid_bpf_helpers.h:117:31: error:
 declaration of 'struct bpf_wq' will not be visible outside of this function
Message-ID: <abL184dNU_lO2JsP@beelink>
References: <202603111558.KLCIxsZB-lkp@intel.com>
 <20260311160618-dbfa08f6-8cfa-4f81-94a2-d6d97f79ae93@linutronix.de>
 <abGeK0FpNn5uXi8B@beelink>
 <20260312073810-db531b6e-ed24-4a55-865e-e7b94e90b8e6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260312073810-db531b6e-ed24-4a55-865e-e7b94e90b8e6@linutronix.de>

On Mar 12 2026, Thomas Weißschuh wrote:
> Hi Benjamin,
> 
> thanks for the quick response.
> 
> On Wed, Mar 11, 2026 at 06:05:25PM +0100, Benjamin Tissoires wrote:
> > On Mar 11 2026, Thomas Weiï¿½schuh wrote:
> > > could you take a look at the report below?
> > > This looks like an issue in the HID BPF subsystem, surfaced by my
> > > unrelated change. Does this ring a bell for you?
> > > 
> > > I wasn't able to reproduce it so far, but will continue looking into it.
> > 
> > Both struct bpf_wq and struct hid_device should be generated in the
> > vmlinux.h that we include in the selftests. So this is definitely not
> > related to your patch AFAICT.
> 
> Ack. To be sure I sent this branch again through 0day and will see if it
> breaks on the same commit.
> 
> > Looking in the config, we have `# CONFIG_HID_SUPPORT is not set` -> so
> > that would explain why struct hid_device is not available. But in that
> > case, why are the HID selftests even built?
> 
> CONFIG_DEBUG_INFO_BTF is also not set. So there should be no vmlinux.h
> at all in the first. Which is exactly what happens in my attempts
> to reproduce the issue. But even when fixing that up, the issue persists.
> 
> > The bpf_wq bits should be related to a similar-ish issue where one
> > config setting is not set and so it's not included in the final BTF.
> 
> I'll look into how exactly things end up in vmlinux.h.
> At least the headers for 'struct bpf_wq' are always included somewhere.
> But maybe the type also needs to be used to define some structure.
> 
> > I paged out how we can ignore selftests based on the .config, so if you
> > have any hints, that would be nice :)
> 
> Inspecting the kernel configuration might be hard, as there might be no file
> for it available. Could you use vmlinux.h itself for feature detection?
> 

Actually I think I remember the rationale:
- because working with config is hard, we just hide any struct
	definition we need in progs/hid_bpf_helpers.h before including
	vmlinux.h
- then we manually define them

So it looks like this is a step I forgot to make when I added the last
few bits: redefine struct bpf_wq and struct hid_device.

Technically we shouldn't even need to redefine the entire struct, but
only the bits we are accessing, because bpf with CO-RE will do the
offsets for us :)

Would the following patch fixes the issue?:
---
From bf4030f8116a4bcafe9f8d84f3d03dd2eedc58a4 Mon Sep 17 00:00:00 2001
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Thu, 12 Mar 2026 18:29:40 +0100
Subject: [PATCH] selftests/hid: fix compilation when bpf_wq and hid_device are
 not exported

This can happen in situations when CONFIG_HID_SUPPORT is set to no, or
some complex situations where struct bpf_wq is not exported.

So do the usual dance of hiding them before including vmlinux.h, and
then redefining them and make use of CO-RE to have the correct offsets.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/progs/hid_bpf_helpers.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index 80ab60905865..2c6ec907dd05 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -8,9 +8,11 @@
 /* "undefine" structs and enums in vmlinux.h, because we "override" them below */
 #define hid_bpf_ctx hid_bpf_ctx___not_used
 #define hid_bpf_ops hid_bpf_ops___not_used
+#define hid_device hid_device___not_used
 #define hid_report_type hid_report_type___not_used
 #define hid_class_request hid_class_request___not_used
 #define hid_bpf_attach_flags hid_bpf_attach_flags___not_used
+#define bpf_wq bpf_wq___not_used
 #define HID_INPUT_REPORT         HID_INPUT_REPORT___not_used
 #define HID_OUTPUT_REPORT        HID_OUTPUT_REPORT___not_used
 #define HID_FEATURE_REPORT       HID_FEATURE_REPORT___not_used
@@ -29,9 +31,11 @@
 
 #undef hid_bpf_ctx
 #undef hid_bpf_ops
+#undef hid_device
 #undef hid_report_type
 #undef hid_class_request
 #undef hid_bpf_attach_flags
+#undef bpf_wq
 #undef HID_INPUT_REPORT
 #undef HID_OUTPUT_REPORT
 #undef HID_FEATURE_REPORT
@@ -55,6 +59,14 @@ enum hid_report_type {
 	HID_REPORT_TYPES,
 };
 
+struct hid_device {
+	unsigned int id;
+} __attribute__((preserve_access_index));
+
+struct bpf_wq {
+	__u64 __opaque[2];
+};
+
 struct hid_bpf_ctx {
 	struct hid_device *hid;
 	__u32 allocated_size;
-- 
2.52.0
---

Cheers,
Benjamin

> 
> Thomas
> 
> > > On Wed, Mar 11, 2026 at 03:29:54PM +0100, kernel test robot wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
> > > > head:   f7178f159b2a36d070fd43b0d751e4e4415ec39e
> > > > commit: 912632a7fd4cc1eac2778828d92e8fe46939d6bd [37/45] vdso/datapage: Trim down unnecessary includes
> > > > config: riscv-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260311/202603111558.KLCIxsZB-lkp@intel.com/config)
> > > > compiler: riscv64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
> > > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260311/202603111558.KLCIxsZB-lkp@intel.com/reproduce)
> > > > 
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202603111558.KLCIxsZB-lkp@intel.com/
> > > > 
> > > > All errors (new ones prefixed by >>):
> > > > 
> > > >    In file included from progs/hid.c:3:
> > > > >> progs/hid_bpf_helpers.h:117:31: error: declaration of 'struct bpf_wq' will not be visible outside of this function [-Werror,-Wvisibility]
> > > >      117 | extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
> > > >          |                               ^
> > > >    progs/hid_bpf_helpers.h:118:32: error: declaration of 'struct bpf_wq' will not be visible outside of this function [-Werror,-Wvisibility]
> > > >      118 | extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
> > > >          |                                ^
> > > >    progs/hid_bpf_helpers.h:119:39: error: declaration of 'struct bpf_wq' will not be visible outside of this function [-Werror,-Wvisibility]
> > > >      119 | extern int bpf_wq_set_callback(struct bpf_wq *wq,
> > > >          |                                       ^
> > > > >> progs/hid.c:448:16: error: field has incomplete type 'struct bpf_wq'
> > > >      448 |         struct bpf_wq work;
> > > >          |                       ^
> > > >    progs/hid.c:448:9: note: forward declaration of 'struct bpf_wq'
> > > >      448 |         struct bpf_wq work;
> > > >          |                ^
> > > > >> progs/hid.c:487:18: error: incompatible pointer types passing 'struct bpf_wq *' to parameter of type 'struct bpf_wq *' [-Wincompatible-pointer-types]
> > > >      487 |         if (bpf_wq_init(wq, &hmap, 0) != 0)
> > > >          |                         ^~
> > > >    progs/hid_bpf_helpers.h:117:39: note: passing argument to parameter 'wq' here
> > > >      117 | extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
> > > >          |                                       ^
> > > >    progs/hid.c:490:26: error: incompatible pointer types passing 'struct bpf_wq *' to parameter of type 'struct bpf_wq *' [-Wincompatible-pointer-types]
> > > >      490 |         if (bpf_wq_set_callback(wq, wq_cb_sleepable, 0))
> > > >          |                                 ^~
> > > >    progs/hid_bpf_helpers.h:119:47: note: passing argument to parameter 'wq' here
> > > >      119 | extern int bpf_wq_set_callback(struct bpf_wq *wq,
> > > >          |                                               ^
> > > >    progs/hid.c:493:19: error: incompatible pointer types passing 'struct bpf_wq *' to parameter of type 'struct bpf_wq *' [-Wincompatible-pointer-types]
> > > >      493 |         if (bpf_wq_start(wq, 0))
> > > >          |                          ^~
> > > >    progs/hid_bpf_helpers.h:118:40: note: passing argument to parameter 'wq' here
> > > >      118 | extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
> > > >          |                                        ^
> > > >    progs/hid.c:503:24: error: incomplete definition of type 'struct hid_device'
> > > >      503 |         int hid = hid_ctx->hid->id;
> > > >          |                   ~~~~~~~~~~~~^
> > > >    progs/hid_bpf_helpers.h:59:9: note: forward declaration of 'struct hid_device'
> > > >       59 |         struct hid_device *hid;
> > > >          |                ^
> > > >    8 errors generated.
> > > > 
> > > > -- 
> > > > 0-DAY CI Kernel Test Service
> > > > https://github.com/intel/lkp-tests/wiki
> > > 
> 
