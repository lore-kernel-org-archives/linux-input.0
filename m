From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/5] input: New MATRIX_KEY macro
Date: Sun, 8 Feb 2009 08:41:11 -0800
Message-ID: <200902080841.11912.david-b@pacbell.net>
References: <BD79186B4FD85F4B8E60E381CAEE1909011A5466@mi8nycmail19.Mi8.com> <BD79186B4FD85F4B8E60E381CAEE19090120BD37@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:42068 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752557AbZBHQlN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 8 Feb 2009 11:41:13 -0500
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE19090120BD37@mi8nycmail19.Mi8.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: hartleys <hartleys@visionengravers.com>
Cc: linux-input@vger.kernel.org

On Friday 06 February 2009, hartleys wrote:
> + * Macro to pack the row/col of a key on a matrix keypad and it's
> associated
> + * KEY_* code into into an array. =A04 bits are used for both the ro=
w and
> column
> + * allowing for up to a 16x16 keypad. =A0The row (_r) and column (_c=
) are
> + * interchangable depending on a keypad drivers usage.

Patch arrived horribly line-wrapped...
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
