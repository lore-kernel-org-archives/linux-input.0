From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/1] input: touchscreen: Remove duplicate ft6236 driver
Date: Mon,  1 Aug 2016 10:16:01 +0200
Message-ID: <1470039362-3271-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree <devicetree@vger.kernel.org>, Sean Cross <xobs@kosagi.com>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.or>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi All,

December 19th 2015 I noticed that a new ft6236 driver had been added to
the kernel, and that it was in essence just a re-implementation of the
M09 protocol from the edt-ft5x06 driver, IOW it contains 100% duplicate
code. I asked the submitter and authors of the new ft6236 driver to test
there devices with the edt-ft5x06 driver instead, but I got no reply.

January 26th 2016 I asked the submitter and authors of the new ft6236
driver to test with the edt-ft5x06 driver again, but again got no reply.

Given the lack of response from the submitter / authors of the ft6236
driver I believe it is best to just remove it. I've double checked and
the edt-ft5x06 driver is 100% compatible both wrt wire protocol usage,
as wrt to the reset gpio usage (and the gpio name in dt).

Regards,

Hans
