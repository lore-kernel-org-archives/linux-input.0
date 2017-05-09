From: Tomohiro Yoshidomi <sylph23k@gmail.com>
Subject: Re: [PATCH v8] Input: psxpad-spi - Add PlayStation 1/2 joypads via
 SPI interface Driver
Date: Tue, 9 May 2017 10:50:11 +0900
Message-ID: <CAGeZN5NFCRhY+KRgtj0Ad7yJvsh7dUvjUpMfGAiVOHiGkmq9qQ@mail.gmail.com>
References: <1494294412-3122-1-git-send-email-sylph23k@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494294412-3122-1-git-send-email-sylph23k@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, =?UTF-8?B?5ZCJ5a+M5pm65a+b?= <sylph23k@gmail.com>
List-Id: linux-input@vger.kernel.org

Mr.Torokhov

Hi.
I fixed source, and sent v8 patch to you.

* FF codes ('CONFIG_JOYSTICK_PSXPAD_SPI_FF' defined),
  put together in one place.

* psxpad_spi_suspend() stub removed again.

Regard.

---
Tomohiro Yoshidomi <sylph23k@gmail.com>
