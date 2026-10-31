Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793469243;
	b=nWTErpAjfBSyMzhr+f6iA/5yL9fBXiDKN2ciBacMJ8AIdbzHw8tCap6wwuBEuapICbdo
	 eLrIflnWmvNx8uUvLbKQH6R8JI/HKCzQgBKDWj52v9bQIr3hY/8NKHSpgVRCj+4ClpzB2
	 VR7KtOolcQOLG7hQJNVVshgQc/q1byTEbtLKkvMriLURXzRbWuda+TivxK9Pes37uG9rC
	 Z9k0BxIpYXJU0CPLB61E9fdOm4edSyLD0tr3FoNOwkLLr+PhHfMipWiL+qCurKNBKM027
	 bbRXtU+iZYa9+KizYA+6R31lQQWxYrWQ8WrWFoyCHdEy70Qqc2WXkA5BeAju/MZTR/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793469243;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=o3CTMxIICK3g4P20XpmDnNMn4xwsW/AtbdoMWgtZZDI=;
	b=dqHLbcqdiZVHa5GYf6NnBHQ71dWZswU0B2O+3qVsQm3kDvB07pBA5Q7qnx7FBHnxxhhY
	 OugeB1caoLQqcifIB73Rvwzqpwzr03fai9j6QPTHuSf7c/xRcVCoLCT3seJFnzwpjAbmG
	 yjG2ifUElwmRzj5vXP9LlidzvDieOxMwTSdmN+/ks47WNSKgzf40k6W0doLpCqtfVsz/r
	 l+iDfrSuuKO+mr44DMDT0njicoSlYcd5HdeJmDsnsQ5RmjV7u/bPWd9sFCG5+5Q+SBzSN
	 04Hr+V7fNsaCVfhSoRtJuwlxbL0xTgb5UzhNCDhXfF42Q8AhgyUV4N13cgu08EaiGgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpWuuoS+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2643D606A31A
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpWuuoS+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797D41F00919;
	Sat, 31 Oct 2026 17:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793469242;
	bh=o3CTMxIICK3g4P20XpmDnNMn4xwsW/AtbdoMWgtZZDI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MpWuuoS+1QhBa5F209ZfT0EVd43Sjedneqvp+llzftXauN1juazRLqnpx+3luw/i8
	 kzG/6kO8OFM2hEIWT8pzN4olluuIMKrsPqsnlkHgEifK8QFjVlWSn/otflFE6XbkYT
	 cb1Y7zgjH88imzqHnQPK8hj0pHTydyLR7tzt1ISQ6/jtCKFK3d71QcQNyQs2FGDPeT
	 kA3l2loFXK1QfDgiLLbLORq26qM0aGT7VlkQN0KfhGh/Lw6t8GtZ8SVT1M70saQWLR
	 jGBe+Tj03CKarsUxgubV5utSfOMH2urPUNvUMwxyO8AsZgEasNjBmHuljPL0RNKwR8
	 Iv3M7lhPEihKA==
Message-ID: <sashiko-outbox-192078@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 06/17] HID: asus: add triggers inner and outer range
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261031174130.208240-7-denis.benato@linux.dev>
References: <20261031174130.208240-1-denis.benato@linux.dev>
 <20261031174130.208240-7-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 17:54:02 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] HID: asus: AB-BA deadlock between ally_prefs.lock and kernfs activ=
e refs
--

commit e95ac74bc1842538166d7189f1bc71f71eb61de4
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add triggers inner and outer range configuration

This commit adds sysfs attributes to configure the inner and outer trigger
ranges for ROG Ally devices, along with restoring those trigger ranges on
device initialization.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 50b0e60405958..5cf7258bc4273 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -1342,9 +1351,201 @@ static const struct attribute_group ally_right_jo=
ystick_axis_group =3D {
>  	.attrs =3D right_joystick_axis_attrs,
>  };
> =20

[ ... ]

> +static ssize_t ally_trigger_limit_show(char *buf, enum ally_trigger_limi=
t which)
> +{
> +	guard(mutex)(&ally_prefs.lock);
> +=20
> +	if (!ally_prefs.user_cal_support)
> +		return -EOPNOTSUPP;
> +=20
> +	return sysfs_emit(buf, "%u\n", *ally_trigger_limits[which]);
> +}
> +=20
> +static ssize_t ally_trigger_limit_store(struct device *dev, const char *=
buf,
> +					size_t count,
> +					enum ally_trigger_limit which,
> +					int lo, int hi,
> +					const char *group, const char *name)
> +{
> +	u8 value, v[ARRAY_SIZE(ally_trigger_limits)];
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	size_t i;
> +	int ret;
> +=20
> +	ret =3D kstrtou8(buf, 10, &value);
> +	if (ret || value < lo || value > hi)
> +		return -EINVAL;
> +=20
> +	scoped_guard(mutex, &ally_prefs.lock) {
> +		if (!ally_prefs.user_cal_support)
> +			return -EOPNOTSUPP;
> +=20
> +		for (i =3D 0; i < ARRAY_SIZE(v); i++)
> +			v[i] =3D *ally_trigger_limits[i];
> +		v[which] =3D value;
> +=20
> +		ret =3D ally_set_trigger_ranges(hdev, v[ALLY_LEFT_MIN], v[ALLY_LEFT_MA=
X],
> +					      v[ALLY_RIGHT_MIN], v[ALLY_RIGHT_MAX]);
> +		if (ret)
> +			return ret;
> +=20
> +		*ally_trigger_limits[which] =3D value;
> +	}
> +=20
> +	sysfs_notify(&dev->kobj, group, name);
> +=20
> +	return count;
> +}

[ ... ]

> +static const struct attribute_group ally_left_trigger_group =3D {
> +	.name =3D "left_trigger",
> +	.attrs =3D left_trigger_attrs,
> +};
> +
> +static const struct attribute_group ally_right_trigger_group =3D {
> +	.name =3D "right_trigger",
> +	.attrs =3D right_trigger_attrs,
> +};
>  static const struct attribute_group *const ally_cal_attr_groups[] =3D {
>  	&ally_left_joystick_axis_group,
>  	&ally_right_joystick_axis_group,
> +	&ally_left_trigger_group,
> +	&ally_right_trigger_group,
>  };

[Severity: High]
Can registering ally_left_trigger_group and ally_right_trigger_group in
ally_cal_attr_groups[] cause an AB-BA deadlock between ally_prefs.lock and
the kernfs active references on the trigger limit sysfs attributes?

When userspace reads or writes range_lower_limit or range_upper_limit,
kernfs_fop_read_iter() or kernfs_fop_write_iter() acquires the attribute's
active reference (kn->active) before calling ally_trigger_limit_show() or
ally_trigger_limit_store(), which then acquires ally_prefs.lock:

  CPU 0:
  kernfs_fop_read_iter() / kernfs_fop_write_iter()
    kernfs_get_active()               [holds kn->active]
    ally_trigger_limit_show() / ally_trigger_limit_store()
      mutex_lock(&ally_prefs.lock)

Meanwhile, during device removal in ally_sysfs_remove() (or error rollback
in ally_prefs_setup()), ally_prefs.lock is acquired before calling
sysfs_remove_group() on ally_cal_attr_groups[]:

  drivers/hid/hid-asus.c:ally_sysfs_remove() {
      ...
      guard(mutex)(&ally_prefs.lock);
      ...
      if (ally_prefs.user_cal_support || ally_prefs.anti_deadzone_support ||
          ally_prefs.resp_curve_support) {
          for (i =3D 0; i < ARRAY_SIZE(ally_cal_attr_groups); i++)
              sysfs_remove_group(&hdev->dev.kobj, ally_cal_attr_groups[i]);
      }
  }

sysfs_remove_group() calls __kernfs_remove() -> kernfs_drain(), which waits
for kn->active to drain while holding ally_prefs.lock:

  CPU 1:
  ally_sysfs_remove() / ally_prefs_setup()
    mutex_lock(&ally_prefs.lock)
    sysfs_remove_group()
      __kernfs_remove()
        kernfs_drain()                [waits for kn->active]

If a sysfs read or write on the new trigger attributes runs concurrently
with device disconnect, unbind, or setup rollback, wouldn't CPU 0 and CPU 1
deadlock waiting on each other?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031174130.2082=
40-1-denis.benato@linux.dev?part=3D6
