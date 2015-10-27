From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] input: Add keyreset driver.
Date: Tue, 27 Oct 2015 02:04:39 -0700
Message-ID: <20151027090439.GA12315@dtor-ws>
References: <1445934753-5627-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33427 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbbJ0JEm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Oct 2015 05:04:42 -0400
Content-Disposition: inline
In-Reply-To: <1445934753-5627-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?B=E1lint?= Czobor <czoborbalint@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>

Hi B=E1lint,

On Tue, Oct 27, 2015 at 09:32:33AM +0100, B=E1lint Czobor wrote:
> From: Arve Hj=F8nnev=E5g <arve@android.com>
>=20
> Add a platform device in the board file to specify a reset key-combo.
> The first time the key-combo is detected a work function that syncs
> the filesystems is scheduled. If all the keys are released and then
> pressed again, it calls panic. Reboot on panic should be set for
> this to work.

Mathieu Poirier integrated keyreset functionality into sysrq, see
3d289517dfd48f6487efda81543c3dda8b0e66f2 and
154b7a489a5b1d808323b933b04864958c2f1056

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
