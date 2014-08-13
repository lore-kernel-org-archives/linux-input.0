From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: [Question: Drivers/input/evdev.c] What is the use of write function
 in evdev_fops?
Date: Wed, 13 Aug 2014 22:16:34 +0530
Message-ID: <CADYu30-WqEUF-BiefJBo9yWUpKKX_zoLZGXsrJSdC46N8w0OVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:65018 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165AbaHMQqg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Aug 2014 12:46:36 -0400
Received: by mail-lb0-f175.google.com with SMTP id 10so3570lbg.34
        for <linux-input@vger.kernel.org>; Wed, 13 Aug 2014 09:46:34 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dear Mr. Torokhov and Linux-Input Community,
Greetings of the day !! :)

I have not seen some good use of write function in input subsystem.
I am trying find the good uses of write function in Input subsystem,
but could not find the solution over internet.
Can you please help in answering my query below:

As you know, in evdev.c file, fops is defined as below
struct file_operations evdev_fops = {
.read           = evdev_read,
.write          = evdev_write,
...
}

So in what cases, evdev_write function is used ?
One case I can think of is that, it can be used in input device simulator
to write the recorded data back into buffer.

Thanks and Regards,
Aniroop Mathur
