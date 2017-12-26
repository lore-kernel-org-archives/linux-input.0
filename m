From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 0/1] Input: inline macros for MODULE_LICENSE, etc
Date: Tue, 26 Dec 2017 10:04:31 -0800
Message-ID: <1514311471.3468.8.camel@perches.com>
References: <1514307905-3486-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0115.hostedemail.com ([216.40.44.115]:50280 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751107AbdLZSEf (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 26 Dec 2017 13:04:35 -0500
In-Reply-To: <1514307905-3486-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tue, 2017-12-26 at 18:05 +0100, Julia Lawall wrote:
> Inline macro for MODULE_LICENSE to make the license information easy to
> find, eg with grep.  Inline the other module-related macros at the same
> time.

Perhaps it'd be better to not make this
dependent on a MODULE_LICENSE use, but allow
any #define foo/#define MODULE_<FOO> foo
where foo is used once to be converted.

