From: Paul Donohue <linux-kernel@paulsd.com>
Subject: Re: [PATCH v2] Input: ALPS - Fix TrackStick support for SS5 hardware
Date: Tue, 8 Nov 2016 09:24:56 -0500
Message-ID: <20161108142456.GJ2927@TopQuark.net>
References: <20161024210122.GA2919@TopQuark.net>
 <20161105163047.GE2927@TopQuark.net>
 <20161105164458.GF2927@TopQuark.net>
 <201611062059.35358@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Lepton.TopQuark.net ([168.235.66.66]:43190 "EHLO
        Mail2.TopQuark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbcKHOY7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2016 09:24:59 -0500
Content-Disposition: inline
In-Reply-To: <201611062059.35358@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org, Ben Gamari <ben@smart-cactus.org>, Michal Hocko <mhocko@suse.com>

On Sun, Nov 06, 2016 at 08:59:34PM +0100, Pali Roh=E1r wrote:
> Anyway, I looked into alps.c source code and I see there another
> problem with ss4 devices. Function alps_decode_ss4_v2() calls
> input_report_*() functions without input_sync(). But all those
> input_report_*() should be in alps_process_packet_ss4_v2().
>=20
> Would you like to fix this problem?

I think this part actually functions properly as-is because=20
alps_process_packet_ss4_v2() always calls input_sync() after
alps_decode_ss4_v2() calls input_report_*().

But I definitely agree this code path is confusing and inconsistent=20
with the rest of alps.c.  I'll take another stab at cleaning this up.

Thanks,
-Paul
