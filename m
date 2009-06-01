From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Mon, 1 Jun 2009 11:43:57 +0800
Message-ID: <f17812d70905312043q4d8e18pf9e2daaa4aeed641@mail.gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>
	 <20090531142027.GA22540@n2100.arm.linux.org.uk>
	 <f17812d70905310729r501ed41fja622392c187c5cbb@mail.gmail.com>
	 <200905311038.23807.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:40851 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351AbZFADn4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 May 2009 23:43:56 -0400
Received: by qw-out-2122.google.com with SMTP id 5so4887351qwd.37
        for <linux-input@vger.kernel.org>; Sun, 31 May 2009 20:43:57 -0700 (PDT)
In-Reply-To: <200905311038.23807.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Uli Luckas <u.luckas@road.de>, linux-arm-kernel@lists.arm.linux.org.uk, Marek Vasut <marek.vasut@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, Jun 1, 2009 at 1:38 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Sunday 31 May 2009 07:29:08 Eric Miao wrote:
>> On Sun, May 31, 2009 at 10:20 PM, Russell King - ARM Linux
>>
>> <linux@arm.linux.org.uk> wrote:
>> > On Sun, May 31, 2009 at 10:12:25PM +0800, Eric Miao wrote:
>> >> +static void __devinit build_keycodes(struct matrix_keypad *keypa=
d)
>> >> +{
>> >> + =C2=A0 =C2=A0 struct matrix_keypad_platform_data *pdata =3D key=
pad->pdata;
>> >> + =C2=A0 =C2=A0 struct input_dev *input_dev =3D keypad->input_dev=
;
>> >> + =C2=A0 =C2=A0 uint32_t *key;
>> >> + =C2=A0 =C2=A0 int i;
>> >> +
>> >> + =C2=A0 =C2=A0 keypad->keycodes =3D kzalloc(MATRIX_MAX_KEYS * si=
zeof(int),
>> >> GFP_KERNEL);
>> >
>> > This doesn't check for failure...
>>
>> Oops, updated (together with the release) as below:
>
> Eric, could you please send me this patch as a diff to the original
> one you sent?
>

Sorry, I used 'git commit --amend' for this and I'm not sure if I can
recover the diff. I'll paste the changed part here instead:

+	keypad->keycodes =3D kzalloc(MATRIX_MAX_KEYS * sizeof(int), GFP_KERNE=
L);
+	if (keypad->keycodes =3D=3D NULL)
+		return -ENOMEM;
+
+	key =3D &pdata->key_map[0];
+	for (i =3D 0; i < pdata->key_map_size; i++, key++) {
+		keypad->keycodes[KEY_ROWCOL(*key)] =3D KEY_VAL(*key);
+		set_bit(KEY_VAL(*key), input_dev->keybit);
+	}
+	return 0;

returns something in 'build_keycodes()'.

+	err =3D build_keycodes(keypad);
+	if (err)
+		goto err_free_input;
+
=2E..
+
+err_unregister:
+	input_unregister_device(input_dev);
+err_free_keycodes:
+	kfree(keypad->keycodes);
+err_free_input:
+	input_free_device(input_dev);
+err_free_keypad:
+	kfree(keypad);
+	return err;

add one more exiting path when build_keycodes() failed

+
+	input_unregister_device(keypad->input_dev);
+	kfree(keypad->keycodes);
+	kfree(keypad);
+	return 0;

kfree(keypad->keycodes) in matrix_keypad_remove()
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
