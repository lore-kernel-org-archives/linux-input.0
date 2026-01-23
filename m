Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EF82D0C9D
	for <linux-input@vger.kernel.org>; Fri, 23 Jan 2026 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769208881; cv=pass; b=LQ1MQ/lNOJKDzScdDZK4YZp9076kHtvMXs3dvBrgx1DkMyOWWBDUNgtHU5VKKxQuyeF68C7Lj9+MUS8mSl4pPB6pkTqgg+TaCFrrxcvrEswlGPVh6IjPSS0OzINEmsWEyuChjxnKrrd/0oOMM6BD7R0N+6eE1hRsfoKlgQ8Ymqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769208881; c=relaxed/simple;
	bh=VldxMb4kLeZCJLUNoWpFhluPeX7IeEzpYKxYC2DNOyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0ObArHTNmpylB61cU/1jBM8faPvWZeuwHd9+x/Buaq/q9wfH7RbQARe4VHzZ2majik9HMMTTAIMnlYvYcKhEDG65sAdZXmXYvXPRcx6Fe+eUf4jqhsehpfyzqauU8taj6502mTEsH+eDpZdZ0RC0NSH1rm520AEvIsIJg3X2hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9jDmZCc; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9jDmZCc"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b4520f6b32so4419791eec.0
        for <linux-input@vger.kernel.org>; Fri, 23 Jan 2026 14:54:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769208868; cv=none;
        d=google.com; s=arc-20240605;
        b=XssISdEdNN6rFoWjkwc27mHvsT4TWQlbbCJMvh1AUyZlpJwhTGAFrb+IxTLDZ31LbC
         fFk9QGIXKs3gvUOm4hRTuv6Qr4PKk1O8IWQ7CRQaWpJ8xF9fjK/Fpstnr3nn12jKnkZV
         YU8ClJPF6um7wYK17LHtme+eE3sqdaz7ciX47vdDi76r/Seaih5aKu03H802YYUn8KPn
         G7IawoHzgaP2cWrxwGWPsKN3DeoEmezAvDMNWmfpROQaMnDJ6n3oJ4+I1o+svW1IAnaw
         uLjPjHA8pvUynp/LgvwGc1tapFgF4DSLRev5/aF/zl/aTedeIYx+WcX5ATSzhKLcHTz8
         u1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yDcIyM6dRIZ8Bjv67FvDZaFkSGXxbbjQiJ33Culq89E=;
        fh=XvK+Gzrs51AqQXPK5YJ0MYqJOd7ra4WxnCmShyxu1ZY=;
        b=kH5M4VojSUpxGixNy59eBhREnPmfx3awRIt60aRjnq9iHZX0DRewREFMrVWZxsHaYO
         DAQ0w5KUb/+pqlT3i+mH2lRwgIOZzQF7BhXDdJket2lCiz8/bs9ZMgs5yrdkYyqjhv8U
         xcPM6TED92m+nwyVL+zwDLP1pE/rPUmuy5dZcQBd6hjK5kyMTeN4Kg325XMD5M4cWaLR
         y1gIRDXOZQ9mqm9wgAjfnYi96vsj3JIKBJRSs14Bp/PBMUn2SadJ5o9DeGkIjDSyNCJI
         XvJpnI0hs4hyEkvRK6OjSXKJcdakZeBxWKhak8XknH3uk2Xd6dU66mcemgOnawHx3pNM
         tgrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769208868; x=1769813668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDcIyM6dRIZ8Bjv67FvDZaFkSGXxbbjQiJ33Culq89E=;
        b=j9jDmZCc0NU348g+Kfs42PDPWjkashiFk7uFSmOV4Tk2plna0ZZ2M7PGaUFFGht5PW
         tPx99pTQ+h00USme/+2f1A8ZNK9qCcGIOj1TLPGDwv1q0SR6L9Ryf6ikpbkKiy4znjX0
         HSKXq8PcrKc2TTzEOjxnMhaqdGByq9i+rBfn7cVZxy5w6lZXsbnORS5JpZp+AKp1+PYu
         xkSmN3LgWSp1QtIA5vF8cqDZQLXaD50PHcujDWQinQGAKhYYAqEWJ/smMkORs8eumv7W
         CA4UUSok6IXHMxxf07H/rUYgyWETyAOm8igpepSl3vPixDrpIE6LMUsmUOgsPCFWpbLJ
         cPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769208868; x=1769813668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yDcIyM6dRIZ8Bjv67FvDZaFkSGXxbbjQiJ33Culq89E=;
        b=TcFaR9X7XbowqR/+bXPH7gY/NRYPIY+0x0+dpA+yzxzGNIneLm02tdgs189tTx3yZ1
         lJmDkJ8BRYtR1CdlokVZ7e6fkChdEHJQqkFA2kR7EPO8pnLQn7ZvwnOBfoc6oJ467+/y
         iAPH2Xhd8nUVO69HzLTl+r0KDky7jLGL4tdjiXkwq3nYvNMd1gzJ1a8pyGwgTPYWFoDO
         v9JQzqd0aaCSRGO/2qQk59rhW+mMRObopFphqOE733JvdMcyDT/YJcnPyxi6GuRyuw4h
         YX6tX5qmMp2T6+24YiFlsh6hcYp+JnSkFv8QrMutMeeJiGG6LuZjywWTBNFeHgvA7apx
         96vA==
X-Forwarded-Encrypted: i=1; AJvYcCWGZ1kidZUv4kql8Gn4f2++Z1unSNYzLA8nOM8HZyVK7s3Iw+a3j80WGUyCnq5Orhh6tsHK0JsTDJXIZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzz8ckq8wRznO/eYtRAfDkPAfRqyTDwzW7hImhrkbrYWYJEpxC
	HYhKzcDFaiqD48VV2ENoMx/ezIKiKKRYF9gf/l2Lu0hCNebMGamo0LPJ6U7UzU7zYpzzCyeIjdp
	FTcLRFepU3xUUhv9Q4IcYYUPdOIA5y0I=
X-Gm-Gg: AZuq6aJaMv1iL689z3Rrir0Wtt4pg9hB50BxGdFZIIBC85Rl+y5Nj9x1M09UQgiz2K/
	sJ6NQPETqOIiSc0pkWgabGX20kttN+LrmYAQ0mSo1RztFZNEmi3w0YB8mX7oQh+jITIu4Sc9+rk
	wTyP6lR+vpJC6hYVKXCu7ZrhPdMRwWAER8Ke3I817eXeJNbMj/8fwHVFbdTq9/7VrGSpb4JEfiY
	57H1PylZyDggM8xv9gNWjLRwmUVW9HjgoZRQUgjwiuKSUBSKnEjiOIobApiRqUQhV0A2TuSpv71
	9EdhZl19JXqkvbAcQotVmFdGs0nHSA==
X-Received: by 2002:a05:7300:724d:b0:2b0:4902:c55c with SMTP id
 5a478bee46e88-2b7399b4a2emr2603459eec.18.1769208867539; Fri, 23 Jan 2026
 14:54:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220204811.3539836-1-alex.t.tran@gmail.com> <38r99s88-7pp2-6s6n-2148-34s5rrs4s225@xreary.bet>
In-Reply-To: <38r99s88-7pp2-6s6n-2148-34s5rrs4s225@xreary.bet>
From: Erin Skomra <skomra@gmail.com>
Date: Fri, 23 Jan 2026 14:54:16 -0800
X-Gm-Features: AZwV_QipwUq4Ba9n1mG_aQw33uy5jMZwoGwSVewSb4PfIh6xNn40fGEqPKfYZcM
Message-ID: <CAEoswT3Ft=XSeogfob0aitGkUEQY2dqoYcjT1CbeGWwFAsA+KQ@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] selftests: hid: tests: test_wacom_generic: add
 tests for display devices and opaque devices
To: Jiri Kosina <jikos@kernel.org>
Cc: Alex Tran <alex.t.tran@gmail.com>, Benjamin Tissoires <bentiss@kernel.org>, shuah@kernel.org, 
	linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all and thanks so much to Alex for the patch.

We tested and reviewed the patch and everything looks good with one suggest=
ion.

Since the properties are mutually exclusive we'd like you to add one
line to each prop test asserting that the opposite property is NOT
set.

Thanks again,
Erin Skomra
Software Engineer II at Wacom


On Sat, Jan 10, 2026 at 1:20=E2=80=AFAM Jiri Kosina <jikos@kernel.org> wrot=
e:
>
> On Sat, 20 Dec 2025, Alex Tran wrote:
>
> > Verify Wacom devices set INPUT_PROP_DIRECT on display devices and
> > INPUT_PROP_POINTER on opaque devices. Moved test_prop_pointer into
> > TestOpaqueTablet. Created a DirectTabletTest mixin class for
> > test_prop_direct that can be inherited by display tablet test classes.
> > Used DirectTabletTest for TestDTH2452Tablet case.
> >
> > Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
>
> Let me CC Benjamin and Wacom folks to take a look here as well.
>
> > ---
> > Changes in v2:
> > - Removed the tests from the BaseTest class
> > - Removed disabling tests for certain subclasses
> > - Moved test_prop_pointer under TestOpaqueTablet
> > - Created DirectTabletTest mixin class
> > - Moved test_prop_direct under TestDTH2452Tablet
> >  .../selftests/hid/tests/test_wacom_generic.py | 30 +++++++++++--------
> >  1 file changed, 17 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/testing/selftests/hid/tests/test_wacom_generic.py b/=
tools/testing/selftests/hid/tests/test_wacom_generic.py
> > index 2d6d04f0f..9d0b0802d 100644
> > --- a/tools/testing/selftests/hid/tests/test_wacom_generic.py
> > +++ b/tools/testing/selftests/hid/tests/test_wacom_generic.py
> > @@ -598,18 +598,6 @@ class BaseTest:
> >                  if unit_set:
> >                      assert required[usage].contains(field)
> >
> > -        def test_prop_direct(self):
> > -            """
> > -            Todo: Verify that INPUT_PROP_DIRECT is set on display devi=
ces.
> > -            """
> > -            pass
> > -
> > -        def test_prop_pointer(self):
> > -            """
> > -            Todo: Verify that INPUT_PROP_POINTER is set on opaque devi=
ces.
> > -            """
> > -            pass
> > -
> >
> >  class PenTabletTest(BaseTest.TestTablet):
> >      def assertName(self, uhdev):
> > @@ -677,6 +665,13 @@ class TestOpaqueTablet(PenTabletTest):
> >              uhdev.event(130, 240, pressure=3D0), [], auto_syn=3DFalse,=
 strict=3DTrue
> >          )
> >
> > +    def test_prop_pointer(self):
> > +        """
> > +        Verify that INPUT_PROP_POINTER is set on opaque devices.
> > +        """
> > +        evdev =3D self.uhdev.get_evdev()
> > +        assert libevdev.INPUT_PROP_POINTER in evdev.properties
> > +
> >
> >  class TestOpaqueCTLTablet(TestOpaqueTablet):
> >      def create_device(self):
> > @@ -862,7 +857,16 @@ class TestPTHX60_Pen(TestOpaqueCTLTablet):
> >          )
> >
> >
> > -class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, Touch=
TabletTest):
> > +class DirectTabletTest():
> > +    def test_prop_direct(self):
> > +        """
> > +        Verify that INPUT_PROP_DIRECT is set on display devices.
> > +        """
> > +        evdev =3D self.uhdev.get_evdev()
> > +        assert libevdev.INPUT_PROP_DIRECT in evdev.properties
> > +
> > +
> > +class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, Touch=
TabletTest, DirectTabletTest):
> >      ContactIds =3D namedtuple("ContactIds", "contact_id, tracking_id, =
slot_num")
> >
> >      def create_device(self):
> > --
> > 2.51.0
> >
>
> --
> Jiri Kosina
> SUSE Labs
>
>
