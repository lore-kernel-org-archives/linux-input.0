From: Przemo Firszt <przemo@firszt.eu>
Subject: Re: [PATCH] HID: wacom: Fix wacom_probe error handling
Date: Tue, 18 Sep 2012 23:12:49 +0100
Message-ID: <1348006369.1991.5.camel@localhost>
References: <1347848940.20002.1.camel@phoenix>
	 <6b8f36c5518404598ba8c60eea6005d6.squirrel@webmail.firszt.eu>
	 <CAF+7xW=Vky_6G3Z0rEj-Ski+fFPk-02g0EEaGB2kQOKakJEqvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wren.arvixe.com ([50.97.138.99]:40191 "EHLO wren.arvixe.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755285Ab2IRWMw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Sep 2012 18:12:52 -0400
In-Reply-To: <CAF+7xW=Vky_6G3Z0rEj-Ski+fFPk-02g0EEaGB2kQOKakJEqvA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: axel.lin@gmail.com
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pingc@wacom.com>, linux-input@vger.kernel.org

On Mon, 2012-09-17 at 16:39 +0800, Axel Lin wrote:
> 2012/9/17 Przemo Firszt <przemo@firszt.eu>:
> >
> > Dnia 17 Wrze=C5=9Bnia 2012, 3:29 am, Pn, Axel Lin napisa=C5=82(a):
> >> In the case of goto destroy_leds, we also need to call hid_hw_stop=
(hdev)
> >> and
> >> remove sysfs attribute files we created for speed and oleds.
> >>
> >> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> >> ---
> >>  drivers/hid/hid-wacom.c |   12 ++++++++++--
> >>  1 file changed, 10 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
> >> index a0fafac..fae7fd7 100644
> >> --- a/drivers/hid/hid-wacom.c
> >> +++ b/drivers/hid/hid-wacom.c
> >> @@ -902,10 +902,18 @@ OLED_INIT(7);
> >>  err_ac:
> >>       power_supply_unregister(&wdata->battery);
> >>  err_battery:
> >> -     device_remove_file(&hdev->dev, &dev_attr_speed);
> >> -     hid_hw_stop(hdev);
> >>  destroy_leds:
> >>       wacom_destroy_leds(hdev);
> >> +     device_remove_file(&hdev->dev, &dev_attr_oled0_img);
> >> +     device_remove_file(&hdev->dev, &dev_attr_oled1_img);
> >> +     device_remove_file(&hdev->dev, &dev_attr_oled2_img);
> >> +     device_remove_file(&hdev->dev, &dev_attr_oled3_img);
> >> +     device_remove_file(&hdev->dev, &dev_attr_oled4_img);
> >> +     device_remove_file(&hdev->dev, &dev_attr_oled5_img);
> >> +     device_remove_file(&hdev->dev, &dev_attr_oled6_img);
> >> +     device_remove_file(&hdev->dev, &dev_attr_oled7_img);
> >> +     device_remove_file(&hdev->dev, &dev_attr_speed);
> >> +     hid_hw_stop(hdev);
> >>  err_free:
> >>       kfree(wdata);
> >>       return ret;
> >> --
> >> 1.7.9.5
> > Hi Alex,
> It's Axel.
Hi Axel,
I'm really sorry for that mistake :-(

> > The initial idea was that the OLEDs/LED are not critical for tablet
> > functioning and that's why there was no call of hid_stop_hw if the
> > OLED/LED initialisation faild.
>=20
> Since it is not critical, current code ignore checking return value w=
hen
> device_create_file for speed and oleds.
>=20
> But current code does goto destroy_leds if wacom_initialize_leds fail=
s.
> Which means it returns error code in wacom_probe() and thus it should
> clean up all the allocated resources in the error patch.
>=20
> If you want to ignore wacom_initialize_leds() failure, you should not
> call goto destroy_leds.
>=20
> Comment?
>=20
See my reply to the v2 patch. Thanks for catching that!=20
--
Kind regards,
Przemo

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
