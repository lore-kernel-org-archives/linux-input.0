From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH 0/7] input:use module_i2c{spi}_driver in input drivers
Date: Mon, 09 Jan 2012 10:10:24 +0800
Message-ID: <4F0A4C90.8000709@cn.fujitsu.com>
References: <1324304605-18193-1-git-send-email-gaowanlong@cn.fujitsu.com> <4F06A7B0.3050904@cn.fujitsu.com>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:58487 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753052Ab2AICL0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Jan 2012 21:11:26 -0500
In-Reply-To: <4F06A7B0.3050904@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: gaowanlong@cn.fujitsu.com, Wanlong Gao <wanlong.gao@gmail.com>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>

On 01/06/2012 03:50 PM, Wanlong Gao wrote:

> Hi Dmitry=EF=BC=9A
>=20
> Will you pick this patch set through this merge window?
>=20
> Thanks
> -Wanlong Gao
>=20
>> Hi Dmitry,all:
>> Since Greg has queued this patchset to driver-core-next.
>> http://git.kernel.org/?p=3Dlinux/kernel/git/gregkh/driver-core.git;a=
=3Dcommitdiff;h=3D907d0ed1c84114d4e8dafd66af982515d3739c90
>> http://git.kernel.org/?p=3Dlinux/kernel/git/gregkh/driver-core.git;a=
=3Dcommitdiff;h=3D7c92784a546d2945b6d6973a30f7134be78eb7a4
>> http://git.kernel.org/?p=3Dlinux/kernel/git/gregkh/driver-core.git;a=
=3Dcommitdiff;h=3D3acbb0142d48713a8f65cde678a54f419801c189


These three patches are already merged to mainline, could you please pi=
ck this patch set?


Thanks
-Wanlong Gao

>>
>> So, is it time to queue these pathes to input-next, too?
>>
>> Just use module_i2c_driver() and module_spi_driver() in input i2c
>> and spi drivers instead.
>>
>>
>> Thanks
>> -Wanlong Gao
>>
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
