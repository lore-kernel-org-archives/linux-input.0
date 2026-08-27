Received: from bg-bec.cloudflare-smtp.org (bg-bec.cloudflare-smtp.org [104.30.16.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F836448D01
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.30.16.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834648; cv=none; b=KqA8Tuqv+ZiFhpTTslcVJ8se7E+dwPZbaL9RjhXuOsrT9/EzayHTRIVLzb1HR2A+CtfEVVVWJx7fVqNmKu+0f6ewolaSznz8xN+94D6Ygwh+MR9MFhH0FWYDgb/TKa4nI8KX2FOCu97k+lwAXvzS1URPigANNFdey1zylUOOopI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834648; c=relaxed/simple;
	bh=LPv4Z/p6wQWKl9SGeAjGOmxLHSFAlnBjojdhStDI3rw=;
	h=From:Message-ID:Date:Subject:To:MIME-Version:Content-Type; b=KV1aWpPu5CBHw5f9uKGTu0hoEn1vSP4ijx6mf6w7VkH5aHqzvZ7IHyFTvHgf9W+tKVjl5BtuBrk3iwsav6y6bG9TFR+jbBNkS0Kv46KzBOeGTNVrqhTcDgkvhlwhIK/QWizVZvquYLcj69cw7gotFO/xdFAB5KQxW6GYkosUkyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh; spf=pass smtp.mailfrom=cf-bounce.bugs.sh; dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b=JXEjjsap; dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b=VIIPaCr8; arc=none smtp.client-ip=104.30.16.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cf-bounce.bugs.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b="JXEjjsap";
	dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b="VIIPaCr8"
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.org; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834638; x=1788439438; bh=CtMj3tj90W1+L9QjJW
	pEeQE0iVf4lRqG1yY3kLY7D3o=; b=JXEjjsapYvAdFCJaPf8yXT2bGjShTeMz9SotZFU9KytF5
	HxgUgFdqdRJFZ5OBmlWxvb2GKE8iD0LIuHKTPoRMBr38EjPS6R94oBdyrt690P1djqYaeaMG4HZ
	SzPNBRyrgmIBEM11UwRmsJrW8JAKX+h/B8fjhqZBBfoGIGWWCJT0tR+upczaLSqBqqT3yHavh40
	+X+6kU1PNcr8Ps+/m+pebWPtERKYsYN2GuddVLOkfOyeoOPbcirGEK2ufuKSrUaA0+Yub6fHVtv
	d4fWqIfh6gp9pvEQNV0XWH4x82bU+f3mLkkKCF44NO9tIUwZrXFEa/uR0K07PYLw18zp2XLQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=bugs.sh; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834638; x=1788439438; bh=CtMj3tj90W1+L9QjJW
	pEeQE0iVf4lRqG1yY3kLY7D3o=; b=VIIPaCr88eklH5lgODZGfpW88/v+y8GOCIxqkdDnqg3vs
	MUju0K0I+0eG4sIFRD7CdS+dSGC3gRnqG84CvU+A7XGTKl2weO688RmfslCLDe/Lwnbm54+uH08
	b4TEOFm8lGcpWvKdY2YmJTA7RzA8KuA8AF5hEunMALpDb3PYkiV6PoU/DrGXm2udFLN01OetNMc
	/LLUY2uoliB8CVkrEPA1lVKrn0FvGs5fRPuKabCWU5pjLnYNaBWmatcI6QibzZDq+qQwlz3W5A+
	bPFYaK+ZcCXWAyFkEYi2oaDxfJsRVaP59RAO233/IkjUTLesbbNqBGbN+m19RvEtxEHVGVYg==;
Feedback-ID: bugs.sh:5:6:Cloudflare
From: co <co+b240dc164119a46c@bugs.sh>
Message-ID: <UFZgYBPFzraRy8BQcngd1LpE4nCofXZsBVbb@bugs.sh>
Date: Thu, 27 Aug 2026 12:43:52 +0000
Subject: [BUG] drivers/hid: use-after-free in u2fzero_recv()
To: linux-input@vger.kernel.org, "Jiri Kosina" <jikos@kernel.org>, "Benjamin
 Tissoires" <bentiss@kernel.org>, "Andrej Shadura" <andrew.shadura@collabora.co.uk>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

We found a bug reachable in:

    path    drivers/hid
    crash   use-after-free in u2fzero_recv()
    commit  6f232446a629 ("Linux 6.12.77")

Config, environment, the sanitizer report and a C reproducer follow.

=3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    If you patch the bug based on our artifacts, a tag would be
    appreciated:

Reported-by: co+b240dc164119a46c@bugs.sh

    Everything in this mail is validated by the reproducer below.

    We also hold an LLM-generated root-cause analysis and a candidate
    patch. The patch passes an A/B test: the same reproducer panics the
    unpatched kernel and runs clean on the patched one. Neither has had
    human review, so both still require validation before you send or
    apply them. Available on:

        patch.diff  https://bugs.sh/b/b240dc164119a46c/patch.diff
        report.md   https://bugs.sh/b/b240dc164119a46c/report.md

    This is an open science project. The code and the full set of PoCs
    are not public at this moment, as we intend to disclose our findings
    in an ethical way.

    Happy to test patches. Complaints and suggestions about our work
    are welcome at:

        cedalion@bugs.sh

=3D=3D Environment =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    Reproduced on  6f232446a629 ("Linux 6.12.77")
    VM setup       https://bugs.sh/b/b240dc164119a46c/run.sh
    config         https://bugs.sh/b/b240dc164119a46c/config.gz
    poc            https://bugs.sh/b/b240dc164119a46c/repro.c

=3D=3D Sanitizer Report =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in u2fzero_recv.constprop.0 (drivers/hid/hi=
d-u2fzero.c:160)
Read of size 4 at addr ffff88801fd0ad84 by task exploit/5205
CPU: 0 UID: 0 PID: 5205 Comm: exploit Not tainted 6.12.77 #31
Call Trace:
dump_stack_lvl (lib/dump_stack.c:123)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:481)
kasan_report (mm/kasan/report.c:596)
u2fzero_recv.constprop.0 (drivers/hid/hid-u2fzero.c:160)
u2fzero_rng_read (drivers/hid/hid-u2fzero.c:226)
rng_dev_read (drivers/char/hw_random/core.c:223 drivers/char/hw_random/core=
.c:257)
vfs_read (fs/read_write.c:567)
ksys_read (fs/read_write.c:713)
do_syscall_64 (arch/x86/entry/common.c:47  arch/x86/entry/common.c:78)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
Allocated by task 5193:
kasan_save_stack (mm/kasan/common.c:49)
kasan_save_track (mm/kasan/common.c:61  mm/kasan/common.c:70)
__kasan_kmalloc (mm/kasan/common.c:378 mm/kasan/common.c:395)
__kmalloc_noprof (mm/slub.c:4333 mm/slub.c:4344)
usb_alloc_urb (./include/linux/slab.h:882 drivers/usb/core/urb.c:75)
u2fzero_probe (drivers/hid/hid-u2fzero.c:288  drivers/hid/hid-u2fzero.c:344)
hid_device_probe (drivers/hid/hid-core.c:2703 drivers/hid/hid-core.c:2740)
really_probe (drivers/base/dd.c:579 drivers/base/dd.c:657)
__driver_probe_device (drivers/base/dd.c:799)
device_driver_attach (drivers/base/dd.c:1127)
bind_store (drivers/base/bus.c:268)
drv_attr_store (drivers/base/bus.c:125)
sysfs_kf_write (fs/sysfs/file.c:136)
kernfs_fop_write_iter (fs/kernfs/file.c:88 fs/kernfs/file.c:356)
vfs_write (fs/read_write.c:591  fs/read_write.c:683)
ksys_write (fs/read_write.c:737)
do_syscall_64 (arch/x86/entry/common.c:47  arch/x86/entry/common.c:78)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
Freed by task 5223:
kasan_save_stack (mm/kasan/common.c:49)
kasan_save_track (mm/kasan/common.c:61  mm/kasan/common.c:70)
kasan_save_free_info (mm/kasan/generic.c:582)
__kasan_slab_free (mm/kasan/common.c:272)
kfree (mm/slub.c:4651  mm/slub.c:4803)
usb_free_urb.part.0 (drivers/usb/core/urb.c:98)
usb_free_urb (drivers/usb/core/urb.c:98)
hid_device_remove (drivers/hid/hid-core.c:2764)
device_remove (drivers/base/dd.c:570)
device_release_driver_internal (drivers/base/dd.c:1274 drivers/base/dd.c:12=
95)
unbind_store (drivers/base/bus.c:245)
drv_attr_store (drivers/base/bus.c:125)
sysfs_kf_write (fs/sysfs/file.c:136)
kernfs_fop_write_iter (fs/kernfs/file.c:88 fs/kernfs/file.c:356)
vfs_write (fs/read_write.c:591  fs/read_write.c:683)
ksys_write (fs/read_write.c:737)
do_syscall_64 (arch/x86/entry/common.c:47  arch/x86/entry/common.c:78)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
The buggy address belongs to the object at ffff88801fd0ad00
which belongs to the cache kmalloc-192 of size 192
The buggy address is located 132 bytes inside of
freed 192-byte region [ffff88801fd0ad00, ffff88801fd0adc0)
The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1fd0a
flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801ac413c0 ffffea0000af0fc0 dead000000000002
raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GF=
P_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0),=
 ts 19090575597, free_ts 16417876266
post_alloc_hook (./include/linux/page_owner.h:32 mm/page_alloc.c:1592)
get_page_from_freelist (mm/page_alloc.c:1602 mm/page_alloc.c:3540)
__alloc_pages_noprof (mm/page_alloc.c:4840)
alloc_pages_mpol_noprof (mm/mempolicy.c:2271)
new_slab (mm/slub.c:2463 mm/slub.c:2633 mm/slub.c:2687)
___slab_alloc (mm/slub.c:3881)
__slab_alloc.isra.0 (mm/slub.c:3971)
__kmalloc_cache_noprof (mm/slub.c:4024 mm/slub.c:4185 mm/slub.c:4358)
drm_atomic_helper_plane_duplicate_state (./include/linux/slab.h:878 drivers=
/gpu/drm/drm_atomic_state_helper.c:374)
drm_simple_kms_plane_duplicate_state (drivers/gpu/drm/drm_simple_kms_helper=
.c:345)
drm_atomic_get_plane_state (drivers/gpu/drm/drm_atomic.c:545)
drm_client_modeset_commit_atomic (drivers/gpu/drm/drm_client_modeset.c:1030)
drm_client_modeset_commit_locked (drivers/gpu/drm/drm_client_modeset.c:1180)
drm_fb_helper_pan_display (drivers/gpu/drm/drm_fb_helper.c:1372 drivers/gpu=
/drm/drm_fb_helper.c:1431)
fb_pan_display (drivers/video/fbdev/core/fbmem.c:191)
bit_update_start (drivers/video/fbdev/core/bitblit.c:406)
page last free pid 83 tgid 83 stack trace:
free_unref_page (./include/linux/page_owner.h:25 mm/page_alloc.c:1161 mm/pa=
ge_alloc.c:2721)


---
The report format is based on syzbot bug report.

This report is generated by a bot. It may contain errors.
See https://github.com/n132/cedalion for more information.

For any issue with this report, reach out to cedalion@bugs.sh

If the report is already addressed, let us know by replying with:
#co fix: <commit hash>

If the report is a duplicate of another one, reply with:
#co dup: <lore link>

If you want to undo deduplication, reply with:
#co undup


