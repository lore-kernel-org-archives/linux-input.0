From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: input0: bad kobj_uevent_env content in show_uevent()
Date: Mon, 03 Sep 2012 09:01:48 +0200
Message-ID: <87oblnegir.fsf@nemi.mork.no>
References: <20120902075946.GA21198@localhost> <87harg35kh.fsf@nemi.mork.no>
	<20120902163831.GA26191@localhost> <20120903002241.GA20054@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:45537 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923Ab2ICHCS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Sep 2012 03:02:18 -0400
In-Reply-To: <20120903002241.GA20054@kroah.com> (Greg Kroah-Hartman's message
	of "Sun, 2 Sep 2012 17:22:41 -0700")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>, linux-input@vger.kernel.org, chunkeey@googlemail.com, linville@tuxdriver.com, LKML <linux-kernel@vger.kernel.org>

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> On Mon, Sep 03, 2012 at 12:38:31AM +0800, Fengguang Wu wrote:
>=20
>> It also works reliably for me: 300 boots without a single failure.
>>=20
>> Tested-by: Fengguang Wu <fengguang.wu@intel.com>=20
>
> Thanks for figuring this out.  I'll apply it for 3.6, but work to get
> rid of CONFIG_HOTPLUG completly for 3.7 as it just causes problems.

OK, do you want me to propose some commit message, or do you prefer to
write something coherent yourself instead?  In any case, if you need it
for the oneline hack:

Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>



Bj=C3=B8rn
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
