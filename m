From: Joshua Clayton <stillcompiling@gmail.com>
Subject: Re: [PATCH] Input: arizona-haptic - convert to use managed input devices
Date: Mon, 20 Jul 2015 07:48:19 -0700
Message-ID: <2971079.LMgqEoTvan@jclayton-pc>
References: <20150706173841.GA31110@dtor-ws> <20150706214005.GA32140@dtor-ws> <20150717232834.GI39282@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35976 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932429AbbGTOsY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2015 10:48:24 -0400
In-Reply-To: <20150717232834.GI39282@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org

On Friday, July 17, 2015 04:28:34 PM Dmitry Torokhov wrote:
> On Mon, Jul 06, 2015 at 02:40:05PM -0700, Dmitry Torokhov wrote:
> > On Mon, Jul 06, 2015 at 12:33:06PM -0700, Joshua Clayton wrote:
> > > Hi,
> > > It seems to me that swapping error for ret buries the functional changes in 
> > > the patch...
> > > would it be better to split them into a second  cleanup patch?
> > 
> > Fair enough, although I am not sure if I ever get to the renaming again
> > 
> 
> Joshua, does the below look OK to you?
> 
> Thanks!
> 
> > 
> > Thanks.
> > 
> > -- 
> > Dmitry
> > 
> > 
> > Input: arizona-haptic - convert to use managed input devices
> > 
> > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > Using managed input device (via devm_input_allocate_device) simplifies
> > error handling and driver removal paths and also silences CID# 712569.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/misc/arizona-haptics.c |   26 ++++----------------------
> >  1 file changed, 4 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/input/misc/arizona-haptics.c b/drivers/input/misc/arizona-haptics.c
> > index 4dbbed7..4bf6785 100644
> > --- a/drivers/input/misc/arizona-haptics.c
> > +++ b/drivers/input/misc/arizona-haptics.c
> > @@ -170,8 +170,8 @@ static int arizona_haptics_probe(struct platform_device *pdev)
> >  
> >       INIT_WORK(&haptics->work, arizona_haptics_work);
> >  
> > -     haptics->input_dev = input_allocate_device();
> > -     if (haptics->input_dev == NULL) {
> > +     haptics->input_dev = devm_input_allocate_device(&pdev->dev);
> > +     if (!haptics->input_dev) {
> >               dev_err(arizona->dev, "Failed to allocate input device\n");
> >               return -ENOMEM;
> >       }
> > @@ -188,41 +188,23 @@ static int arizona_haptics_probe(struct platform_device *pdev)
> >       if (ret < 0) {
> >               dev_err(arizona->dev, "input_ff_create_memless() failed: %d\n",
> >                       ret);
> > -             goto err_ialloc;
> > +             return ret;
> >       }
> >  
> >       ret = input_register_device(haptics->input_dev);
> >       if (ret < 0) {
> >               dev_err(arizona->dev, "couldn't register input device: %d\n",
> >                       ret);
> > -             goto err_iff;
> > +             return ret;
> >       }
> >  
> >       platform_set_drvdata(pdev, haptics);
> >  
> >       return 0;
> > -
> > -err_iff:
> > -     if (haptics->input_dev)
> > -             input_ff_destroy(haptics->input_dev);
> > -err_ialloc:
> > -     input_free_device(haptics->input_dev);
> > -
> > -     return ret;
> > -}
> > -
> > -static int arizona_haptics_remove(struct platform_device *pdev)
> > -{
> > -     struct arizona_haptics *haptics = platform_get_drvdata(pdev);
> > -
> > -     input_unregister_device(haptics->input_dev);
> > -
> > -     return 0;
> >  }
> >  
> >  static struct platform_driver arizona_haptics_driver = {
> >       .probe          = arizona_haptics_probe,
> > -     .remove         = arizona_haptics_remove,
> >       .driver         = {
> >               .name   = "arizona-haptics",
> >       },
> 
> -- 
> Dmitry
devm for the win.
Yes, that looks good.

-- 
~Joshua Clayton
