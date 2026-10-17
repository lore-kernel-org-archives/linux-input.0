Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA9736B91C
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792242772; cv=none; b=kbqpJuhNwPv2DWHbCA3Wvd8yQH5g57Vzz8l5PHT3o/gGsmdsfRIZHoNp/GielEj+weMAWmpbF3senC1m8UyOOymODT/1z2jBWcqvwcrnEHJLqoNXTKYd+lxDi/w/vrX0XpakisVeEQnzq+8pJdMiD5NEdDCuYtrZ1vaSHffoZlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792242772; c=relaxed/simple;
	bh=b2DbzjEv1ycRQ4BtIbfzVMb7og/98ShD10DRQlMt6tU=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:Message-Id:
	 MIME-Version:Content-Type; b=m4vYnPtrBTNZcKOzV2qgsxSPx8nIkqYc0FunOlqSR+sUOjqmPu0Cca4ADImCSqs4D0IDw8o/eBa3uGOlpx0pKb1VimytUtkDKWX/qTjPtpCsoMw7+8T21eyuDoqqxeMvtCuJQRViqUgnC9CwRfoWf9W4MqgM6gFj32ChZTMz1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0k+tcrb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0k+tcrb"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so8642625e9.2
        for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 06:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792242769; x=1792847569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:in-reply-to:references:from:subject:cc:to:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vVJoU2SfFWooil8mYswD7FtsdjdV0OLch5TOCYNKlq8=;
        b=c0k+tcrb+etztWzjk9ssGQT2kxzkvLKUMKviJpeO5Pj+occ0/PXvT9P1jltTsMAS7/
         QYGZ9B+78nsf25Oynowd2U98i7R4bYuv0H7K9/f1RDQgXz4o7T2dSEWPTpyyV6gI3xmm
         Aq9yjLZfkMU0l69pKNPA1LzuPFSLw13he4oRKlmM97Ge70AH+jTekANgWL9Khlv/A8H/
         PX4UyBl12TCuwxnhVwiavjNUrsykoT0eqjqBSWwgcAv6oSNa77vL9A9e8cpdqr19XoZ2
         4Fwkqh7idY4oyHi2/WVLtNfHnmGiqze0iZDu+L4jV4nT3TZLTbdnxzKcqImT/CAfixH2
         aToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792242769; x=1792847569;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:in-reply-to:references:from:subject:cc:to:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vVJoU2SfFWooil8mYswD7FtsdjdV0OLch5TOCYNKlq8=;
        b=0XBmAxYC3JcTN5z/czbnKFeSplPS1XMmw3TuRayqhvU4l0C1ZLJS2DNFSriDHIDDUX
         9lemXP/NG/soXvbcR6jqmsBgzFUTBZuGMG/ogP3qihKi7PEpaR68Ku2BHH6uLiUmz/de
         J7pohDyBZitC1Kne5nZoMPtybZsdg92opYmsLO2Pnaas6r2BdWYsS76MmQU3K/qnmtO5
         85qYlNsZWoJNl228CpKFDewqXVTQZiEJEFco/LcpKhHnZDT2RvpCRQACLnaJEa1tcLDc
         ERYWOXIHTDEHg3VEFVn0lv76w+TvZH8D6phrpDfbNWAoFYmF9sYinGh1dGEiDi0tT9PD
         pz9Q==
X-Forwarded-Encrypted: i=1; AKwUvBx0lptvedmyX+sOgEcQMZEWij9tn+bSj9eEjhzxvzsVBmDyfgD+1xL77EQbaqaOCLDdONOTnqV9rBNrAA==@vger.kernel.org
X-Gm-Message-State: AFq9FYISHp8lUzdpBO+EIjHNhsRuqxtwj2pIesTVO4QD+RRCF12dM11B
	sWbZMMy9QN8VTJSB8Y/H349pH/IkTdCmARERclFedhCt6eiVRiUCDphjZfa7vQ==
X-Gm-Gg: AYBFou1NRvjl7SoqGggRmX2ZhaBjIPsREzc79/ioOm4fU4e6GY9WekMhfVNSjAIu9o6
	JG1qyGLEBLgKef2AbKiHIDHfeMvTxxPo2ujOjR6PhUC6WQI1NiiwCX2s0UIbCrJnhpQz6d2zdJF
	Q64/NlTk/+zt68wndkbMeJFm4U/VMH324R+8cIPz4WDjM0hJyYSX1abxlpBHAt78Ie4C0QW5S4s
	1DVSVGBWHaN3ZvzmrDaKHE1pIrt2JzDzcxoy27BXfD/SrJtUyPVXEvdeypUkk1CK9Y1tpL9G6fa
	Zz3Qoi3WkDwXSFTvY78wnsL3zvaimS08eDemTFH7iwTqNP3W138fXpiMddpyVvkYsSYkMW9DAGa
	B47U13s+lRQ6pwKlta1AXRV0qXKkEKVeKwHyBjMnZ/0Q1V4KBxbgOFm6DK3xpjc8wUUx2/BBblA
	88q+m1GtNE2pUA5gOwG7YenV/EJsEbi9iatcl/lZQa+vz5fvDYqHKzFk4iABJd753RHboj8L2Uk
	BtlJsXbnT4N
X-Received: by 2002:a05:600c:1389:b0:4a1:ad27:e797 with SMTP id 5b1f17b1804b1-4a1d76074c6mr57411265e9.6.1792242768851;
        Sat, 17 Oct 2026 06:12:48 -0700 (PDT)
Received: from localhost ([2a02:169:1e9:0:8f4d:9ee2:cc35:c67b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b8ebdsm256948975e9.10.2026.10.17.06.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 06:12:48 -0700 (PDT)
Date: Sat, 17 Oct 2026 15:12:47 +0200
To: kernel test robot <lkp@intel.com>
Cc: Vicki Pfau <vi@endrift.com>, oe-kbuild-all@lists.linux.dev,
 linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>
Subject: Re: [hid:for-7.4/nintendo 2/5]
 drivers/hid/hid-nintendo.c:3993:undefined reference to `hid_is_usb'
From: "Silvan Jegen" <s.jegen@gmail.com>
References: <202610171559.gZ0QBMFv-lkp@intel.com>
In-Reply-To: <202610171559.gZ0QBMFv-lkp@intel.com>
Message-Id: <3HN3VLNWTGRM8.2HVANQO7V2MPM@homearch.localdomain>
User-Agent: mblaze/1.4-3-ga04b747 (2026-07-03)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Heyhey!

kernel test robot <lkp@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-7=
.4/nintendo
> head:   77c7155e2707ba5b1d56f3dc1acead48cf17f98d
> commit: 9417132df63e5cd7230433af05198538e759f3ae [2/5] HID: nintendo: Add=
 preliminary Switch 2 controller driver
> config: i386-randconfig-1001-20261016 (https://download.01.org/0day-ci/ar=
chive/20261017/202610171559.gZ0QBMFv-lkp@intel.com/config)
> compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20261017/202610171559.gZ0QBMFv-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202610171559.gZ0QBMFv-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>):
>=20
>    ld: drivers/hid/hid-nintendo.o: in function `switch2_probe':
> >> drivers/hid/hid-nintendo.c:3993:(.text+0x6cd7): undefined reference to=
 `hid_is_usb'

I might be doing something wrong but I have checked out "for-7.4/nintendo"
from the https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
remote and my build finished without errors ...

So I'm not able to reproduce this issue locally.

Cheers,
Silvan


>=20
>=20
> vim +3993 drivers/hid/hid-nintendo.c
>=20
>   3985=09
>   3986	static int switch2_probe(struct hid_device *hdev, const struct hid=
_device_id *id)
>   3987	{
>   3988		struct switch2_controller *ns2;
>   3989		struct usb_device *udev;
>   3990		char phys[64];
>   3991		int ret;
>   3992=09
> > 3993		if (!hid_is_usb(hdev))
>   3994			return -ENODEV;
>   3995=09
>   3996		udev =3D hid_to_usb_dev(hdev);
>   3997		if (usb_make_path(udev, phys, sizeof(phys)) < 0)
>   3998			return -EINVAL;
>   3999=09
>   4000		ret =3D hid_parse(hdev);
>   4001		if (ret) {
>   4002			hid_err(hdev, "parse failed %d\n", ret);
>   4003			return ret;
>   4004		}
>   4005=09
>   4006		ns2 =3D switch2_get_controller(phys);
>   4007		if (IS_ERR(ns2))
>   4008			return PTR_ERR(ns2);
>   4009=09
>   4010		mutex_lock(&ns2->lock);
>   4011		if (ns2->hdev) {
>   4012			mutex_unlock(&ns2->lock);
>   4013			hid_err(hdev,
>   4014				"Second hdev tried to claim same controller, first=3D%p vs seco=
nd=3D%p\n",
>   4015				ns2->hdev, hdev);
>   4016			kref_put(&ns2->refcount, switch2_kref_put);
>   4017			return -EBUSY;
>   4018		}
>   4019		ns2->hdev =3D hdev;
>   4020		hid_set_drvdata(hdev, ns2);
>   4021=09
>   4022		switch (hdev->product | (hdev->vendor << 16)) {
>   4023		default:
>   4024			strscpy(ns2->name, hdev->name, sizeof(ns2->name));
>   4025			break;
>   4026		/* Some controllers have slightly wrong names so we override them=
 */
>   4027		case USB_DEVICE_ID_NINTENDO_NS2_JOYCONR | (USB_VENDOR_ID_NINTENDO=
 << 16):
>   4028			/* Missing the "2" in the name */
>   4029			strscpy(ns2->name, "Nintendo Joy-Con 2 (R)", sizeof(ns2->name));=

>   4030			break;
>   4031		case USB_DEVICE_ID_NINTENDO_NS2_GCCON | (USB_VENDOR_ID_NINTENDO <=
< 16):
>   4032			/* Has "Nintendo" in the name twice */
>   4033			strscpy(ns2->name, "Nintendo GameCube Controller", sizeof(ns2->n=
ame));
>   4034			break;
>   4035		}
>   4036=09
>   4037		ns2->player_id =3D U32_MAX;
>   4038		ret =3D ida_alloc(&nintendo_player_id_allocator, GFP_KERNEL);
>   4039		if (ret < 0)
>   4040			hid_warn(hdev, "Failed to allocate player ID, skipping; ret=3D%d=
\n", ret);
>   4041		else
>   4042			ns2->player_id =3D ret;
>   4043=09
>   4044		ret =3D hid_hw_start(hdev, HID_CONNECT_HIDRAW);
>   4045		if (ret) {
>   4046			hid_err(hdev, "hw_start failed %d\n", ret);
>   4047			goto err_cleanup;
>   4048		}
>   4049=09
>   4050		ret =3D hid_hw_open(hdev);
>   4051		if (ret) {
>   4052			hid_err(hdev, "hw_open failed %d\n", ret);
>   4053			goto err_stop;
>   4054		}
>   4055=09
>   4056		ret =3D 0;
>   4057		if (ns2->cfg)
>   4058			ret =3D switch2_init_controller(ns2);
>   4059=09
>   4060		if (!ret) {
>   4061			mutex_unlock(&ns2->lock);
>   4062			return 0;
>   4063		}
>   4064=09
>   4065		hid_hw_close(hdev);
>   4066	err_stop:
>   4067		hid_hw_stop(hdev);
>   4068	err_cleanup:
>   4069		ida_free(&nintendo_player_id_allocator, ns2->player_id);
>   4070		ns2->hdev =3D NULL;
>   4071		mutex_unlock(&ns2->lock);
>   4072		switch2_controller_put(ns2);
>   4073		kref_put(&ns2->refcount, switch2_kref_put);
>   4074=09
>   4075		return ret;
>   4076	}
>   4077=09
>=20
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


