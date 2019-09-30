From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/6] dt-bindings: max77650: convert the device-tree bindings to yaml
Date: Mon, 30 Sep 2019 15:02:40 +0200
Message-ID: <20190930130246.4860-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series converts all DT binding documents for max77650 PMIC to yaml.

Bartosz Golaszewski (6):
  dt-bindings: mfd: max77650: convert the binding document to yaml
  dt-bindings: input: max77650: convert the binding document to yaml
  dt-bindings: regulator: max77650: convert the binding document to yaml
  dt-bindings: power: max77650: convert the binding document to yaml
  dt-bindings: leds: max77650: convert the binding document to yaml
  MAINTAINERS: update the list of maintained files for max77650

 .../bindings/input/max77650-onkey.txt         | 27 +-----
 .../bindings/input/max77650-onkey.yaml        | 43 ++++++++++
 .../bindings/leds/leds-max77650.txt           | 58 +------------
 .../bindings/leds/leds-max77650.yaml          | 82 ++++++++++++++++++
 .../devicetree/bindings/mfd/max77650.txt      | 47 +----------
 .../devicetree/bindings/mfd/max77650.yaml     | 83 +++++++++++++++++++
 .../power/supply/max77650-charger.txt         | 29 +------
 .../power/supply/max77650-charger.yaml        | 42 ++++++++++
 .../bindings/regulator/max77650-regulator.txt | 42 +---------
 .../regulator/max77650-regulator.yaml         | 51 ++++++++++++
 MAINTAINERS                                   |  4 +-
 11 files changed, 308 insertions(+), 200 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.yaml

-- 
2.23.0
