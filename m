From: Tord Johan Espe <tordjohanespe@gmail.com>
Subject: Feature request for `hid-magicmouse`
Date: Mon, 27 May 2019 20:50:21 +0200
Message-ID: <CA+pK8W-OWvsdcBhJr8Prdz3Sb1AbrF6==XsT4jo0TjwAUHTouw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, rydberg@bitmath.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

This is the first time I have submitted any requests to the Linux
development community, so please excuse me if I'm doing it wrong, but
after reading the docs, it seemed like the correct way to do this was
to identify the people involved with the module and send an email.

My feature request is that I think the scrolling implementation in
`hid-magicmouse.c` should take the number of currently active touches
into consideration when deciding scroll speed.

When using the Apple Magic Mouse in MacOS, scrolling is automatically
slowed down when two fingers are touching the mouse simultaneously.
This is extremely helpful for preventing unwanted scrolling when e.g.
clicking and selecting text, which is, at least for me, really
important for the overall experience. I would love it if the same
behavior could be implemented in the Linux driver.

Best regards,
Tord Johan Espe
