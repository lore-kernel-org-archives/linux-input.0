From: Laura Abbott <labbott@redhat.com>
Subject: [REGRESSION] Touchpad failure after e7348396c6d5 ("Input: ALPS - fix
 V8+ protocol handling (73 03 28)")
Date: Fri, 2 Jun 2017 10:54:52 -0700
Message-ID: <937d0082-5c51-e0b5-dcf9-efade5ecbde5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pali Rohar <pali.rohar@gmail.com>
Cc: Paul Donohue <linux-kernel@PaulSD.com>, Nick Fletcher <nick.m.fletcher@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, scott.s.lowe@gmail.com
List-Id: linux-input@vger.kernel.org

Hi,

Fedora got a bug report https://bugzilla.redhat.com/show_bug.cgi?id=1447327
of a touchpad failure on a Dell Latitude E7370. Testing showed that the
bad commit was

commit e7348396c6d51b57c95c6646c390cd078e038e19
Author: Masaki Ota <masaki.ota@jp.alps.com>
Date:   Fri Mar 17 14:10:57 2017 -0700

    Input: ALPS - fix V8+ protocol handling (73 03 28)
    
    Devices identified as E7="73 03 28" use slightly modified version of V8
    protocol, with lower count per electrode, different offsets, and different
    feature bits in OTP data.
    
    Fixes: aeaa881f9b17 ("Input: ALPS - set DualPoint flag for 74 03 28 devices")
    Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
    Acked-by: Pali Rohar <pali.rohar@gmail.com>
    Tested-by: Paul Donohue <linux-kernel@PaulSD.com>
    Tested-by: Nick Fletcher <nick.m.fletcher@gmail.com>
    Cc: stable@vger.kernel.org
    Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I suspect this particular model needs special handling as well?

Thanks,
Laura
