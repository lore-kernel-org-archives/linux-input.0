From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/1] cap11xx: add runtime PM support
Date: Fri, 21 Aug 2015 09:35:57 -0700
Message-ID: <20150821163557.GE26302@localhost>
References: <1439947289-10750-1-git-send-email-mranostay@gmail.com>
 <1439947289-10750-2-git-send-email-mranostay@gmail.com>
 <20150821003743.GA24710@localhost>
 <CAKzfze-3j6dgSBn6r4ajJLbdU2BHVnCF3Uxdjd-=eMdZt0DAmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33709 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbbHUQgB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Aug 2015 12:36:01 -0400
Received: by pdrh1 with SMTP id h1so28810656pdr.0
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2015 09:36:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKzfze-3j6dgSBn6r4ajJLbdU2BHVnCF3Uxdjd-=eMdZt0DAmA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Aug 20, 2015 at 07:07:28PM -0700, Matt Ranostay wrote:
> On Thu, Aug 20, 2015 at 5:37 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Matt,
> >
> > On Tue, Aug 18, 2015 at 06:21:29PM -0700, Matt Ranostay wrote:
> >>
> >> +static int cap11xx_i2c_remove(struct i2c_client *i2c_client)
> >> +{
> >> +     struct cap11xx_priv *priv = i2c_get_clientdata(i2c_client);
> >> +
> >> +     cap11xx_set_sleep(priv, true);
> >> +     pm_runtime_disable(&i2c_client->dev);
> >> +     pm_runtime_set_suspended(&i2c_client->dev);
> >
> > As I mentioned in my previous review:
> 
> Ok that makes sense. What would be the correct way to do this with
> that in mind?

Maybe try installing a custom devm actioni (devm_add_action)? You want
to ensure that the device is put to sleep only after unregistering input
and LED devices.

Thanks.

-- 
Dmitry
