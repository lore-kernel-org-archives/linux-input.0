Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D1C426EB3
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773127800; cv=none; b=hgdShlJ4NiQhvyL9N0I7BE+GNOe9mKm833gmPAwZekaVIz9Ysq16lgXuYelty0KKWcEwUVzkEoXMPiFAsqn0mYcWRjuLgwZ3+cbpW+ZSCExxjfPGH684UbPU8lkGrzl4qnP4zlNk/N2BV2t5Ah/Am8tRLbA1o0BiuLWBKVdnXMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773127800; c=relaxed/simple;
	bh=gLmiYhsjCO2ewaSKXWLLWhUHbePsZVGcZmhlJxVefm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFWU/qa3IesmMWrTX99eC6jyACdF6ttJtCt2+v6o/35VrwVV/NVYRVWfZAWnmTnuPZB91jkyRb+7WQUFDiaNu3zR0fcfRKcqxXExAL8gRFNGP5owPibzpcXzecR9qzFC3Wysqiyv9HpO7J9Q/ksxOrDHuZJpfLTp2ESTkHfB+Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEdPyJSN; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEdPyJSN"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2be1b5fe11cso9716846eec.0
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 00:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773127798; x=1773732598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxcExIxLmkhlT7+NSIJGyGNNqrKogJfbqsFiKHCpzZM=;
        b=dEdPyJSN8JWBpBxn9ZapJUfRp1bb3MzkQDwNItg5U/1d9x2kaVu2FkAwQjcwnW98Vp
         jr6tXFSorYv8NuK3NpFwJb82c9/hSsKx6WVv6pgY5Csgaot6gRdItei44QRnlZu37ws7
         2imLReW+Khu2tbDbfRihb9W3RK2x8BzdKTnAx1TSzPGApGoop4ooGUOLY1shik8TsHqq
         W0W1aEY2mMDH+FhJnCmMuB0ILZXl0Y8a5HHioB+5N/hXjI/roWH6FUkmuE9+3rEbaUwX
         YEWaYjAFMP35Db6oWPdLGQmbjJJjNGAv+PMCAm483ZYK9/n3x0/1ORYnU7CPkfGP4WeD
         klfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773127798; x=1773732598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BxcExIxLmkhlT7+NSIJGyGNNqrKogJfbqsFiKHCpzZM=;
        b=QgB3+Gg/ctva0pa0ZTOH/zQwzve5GXIHs3hbc6YdyXin+am+aENPx2LU/68SJ51FNI
         1V8JS5vXiFUsfjBEhjqZTiR4++X14rFN5cBKLdMY487Wi2OmfnAUhxkNv9FyGy/9srvg
         jGT9J0zsU+JoGm+3atAGd75Uhl3mwcoOpwWyXLZHOH2XsIPdxWUg+it4XnDWCwd9cK4d
         Zn854HKQyV38hxTZRK74udfnA6VLcCF7F2C9jbiPaojmcWIXlPtEsvl9Lfzunz6G4VFb
         h7BFGywcs9E/+/YPdjILOQufBsbME17vpDAdMmtPJKnrN2SdD0Vb8EI1VZyIw6WUZsRC
         Ud8g==
X-Forwarded-Encrypted: i=1; AJvYcCUvYVprRNea5x+e009Kk/22ewLfIpYqxMUqEUoTdGeP1nnijVIT53pTLtsP7aQU039N3V772ZCLtm+wcw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/xeu5NXzpaSlTGDUdd27scToYhEXA8VGuLMmbPW+Qtu4I+nH8
	kiGG1rZfJgNnN9nk2QceDvyMDsU97iYLUQPeVYYOPDz5qnekgoTvBnDT
X-Gm-Gg: ATEYQzxRN7Ai0HUKqtIDwq9McuZOccUOqIpD4sYczfxsNSeqh56SJWxBkveIB1JRjRf
	BxPNyfPYI9IyPvD8AYCZ6JCF8SETR5rTuQsQzyfaFODCJ0aAdp3+oziAukXE1TRLw92dXjIXj6D
	kMj30IWBdZDNGh2z27BViTtz4MB8WCI44QHwmg9eDqYcYd7uafkF4aj074i4QvQqQY3N0+72iTD
	/Zc0Im7Ei773ddYMcNNKooltTQQLdXapcSAE2JHWfUfR01zJUnOSkS37U9p/l/CecRLHa/wTnQM
	4J02IXls+aDsnHS2HTjldipetSHiyQ4gGJR9ZRXhGTRAJkgZF2fwhXzrEqcFLoxRIv2tjVpQtcz
	vekh3Ok8NiJKHbWBfivpJxyJaMW6kIcOB+Elj97Nuis5vRTvO4Bdycxy2Fj4oYnV9P/cARKa6s7
	Dr5PN6G8qeQ73aEVIHNmHrwttdPIASvMJy7iCUr/noSIs7GSc1KOUY8rh6nd1mwXQLA2J5mAK3t
	CJF
X-Received: by 2002:a05:7300:a887:b0:2be:198e:438 with SMTP id 5a478bee46e88-2be4e01914fmr5746231eec.16.1773127797902;
        Tue, 10 Mar 2026 00:29:57 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be81209142sm721925eec.12.2026.03.10.00.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:29:57 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Richard Hughes <hughsient@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH v6 18/19] HID: hid-lenovo-go: Remove unneeded semicolon
Date: Tue, 10 Mar 2026 07:29:36 +0000
Message-ID: <20260310072937.3295875-19-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310072937.3295875-1-derekjohn.clark@gmail.com>
References: <20260310072937.3295875-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Ni <nichen@iscas.ac.cn>

Remove unnecessary semicolons after switch statements and function
bodies. Most issues were reported by Coccinelle/coccicheck using the
semantic patch at scripts/coccinelle/misc/semicolon.cocci. Additional
instances found during manual code review were also fixed.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go.c | 52 ++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index 54861f2e04fc..d4d26c783356 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -455,7 +455,7 @@ static int hid_go_feature_status_event(struct command_report *cmd_rep)
 			return 0;
 		default:
 			return -EINVAL;
-		};
+		}
 	case FEATURE_IMU_BYPASS:
 		switch (cmd_rep->device_type) {
 		case LEFT_CONTROLLER:
@@ -466,7 +466,7 @@ static int hid_go_feature_status_event(struct command_report *cmd_rep)
 			return 0;
 		default:
 			return -EINVAL;
-		};
+		}
 		break;
 	case FEATURE_LIGHT_ENABLE:
 		drvdata.rgb_en = cmd_rep->data[0];
@@ -481,7 +481,7 @@ static int hid_go_feature_status_event(struct command_report *cmd_rep)
 			return 0;
 		default:
 			return -EINVAL;
-		};
+		}
 		break;
 	case FEATURE_TOUCHPAD_ENABLE:
 		drvdata.tp_en = cmd_rep->data[0];
@@ -515,7 +515,7 @@ static int hid_go_motor_event(struct command_report *cmd_rep)
 			return 0;
 		default:
 			return -EINVAL;
-		};
+		}
 		break;
 	case RUMBLE_MODE:
 		switch (cmd_rep->device_type) {
@@ -527,7 +527,7 @@ static int hid_go_motor_event(struct command_report *cmd_rep)
 			return 0;
 		default:
 			return -EINVAL;
-		};
+		}
 	case TP_VIBRATION_ENABLE:
 		drvdata.tp_vibration_en = cmd_rep->data[0];
 		return 0;
@@ -625,7 +625,7 @@ static int hid_go_os_mode_cfg_event(struct command_report *cmd_rep)
 		return 0;
 	default:
 		return -EINVAL;
-	};
+	}
 }
 
 static int hid_go_set_event_return(struct command_report *cmd_rep)
@@ -699,14 +699,14 @@ static int hid_go_raw_event(struct hid_device *hdev, struct hid_report *report,
 		default:
 			ret = -EINVAL;
 			break;
-		};
+		}
 		break;
 	case OS_MODE_DATA:
 		ret = hid_go_os_mode_cfg_event(cmd_rep);
 		break;
 	default:
 		goto passthrough;
-	};
+	}
 	dev_dbg(&hdev->dev, "Rx data as raw input report: [%*ph]\n",
 		GO_PACKET_SIZE, data);
 
@@ -925,7 +925,7 @@ static ssize_t feature_status_store(struct device *dev,
 		break;
 	default:
 		return -EINVAL;
-	};
+	}
 
 	if (ret < 0)
 		return ret;
@@ -1013,7 +1013,7 @@ static ssize_t feature_status_show(struct device *dev,
 			break;
 		default:
 			return -EINVAL;
-		};
+		}
 		count = sysfs_emit(buf, "%u\n", i);
 		break;
 	case FEATURE_FPS_SWITCH_STATUS:
@@ -1032,7 +1032,7 @@ static ssize_t feature_status_show(struct device *dev,
 		break;
 	default:
 		return -EINVAL;
-	};
+	}
 
 	return count;
 }
@@ -1070,7 +1070,7 @@ static ssize_t feature_status_options(struct device *dev,
 		break;
 	default:
 		return -EINVAL;
-	};
+	}
 
 	if (count)
 		buf[count - 1] = '\n';
@@ -1111,7 +1111,7 @@ static ssize_t motor_config_store(struct device *dev,
 		ret = sysfs_match_string(intensity_text, buf);
 		val = ret;
 		break;
-	};
+	}
 
 	if (ret < 0)
 		return ret;
@@ -1161,7 +1161,7 @@ static ssize_t motor_config_show(struct device *dev,
 			break;
 		default:
 			return -EINVAL;
-		};
+		}
 		if (i >= ARRAY_SIZE(enabled_status_text))
 			return -EINVAL;
 
@@ -1177,7 +1177,7 @@ static ssize_t motor_config_show(struct device *dev,
 			break;
 		default:
 			return -EINVAL;
-		};
+		}
 		if (i >= ARRAY_SIZE(rumble_mode_text))
 			return -EINVAL;
 
@@ -1197,7 +1197,7 @@ static ssize_t motor_config_show(struct device *dev,
 
 		count = sysfs_emit(buf, "%s\n", intensity_text[i]);
 		break;
-	};
+	}
 
 	return count;
 }
@@ -1232,7 +1232,7 @@ static ssize_t motor_config_options(struct device *dev,
 					       enabled_status_text[i]);
 		}
 		break;
-	};
+	}
 
 	if (count)
 		buf[count - 1] = '\n';
@@ -1333,7 +1333,7 @@ static ssize_t device_status_show(struct device *dev,
 		break;
 	default:
 		return -EINVAL;
-	};
+	}
 
 	if (i >= ARRAY_SIZE(cal_status_text))
 		return -EINVAL;
@@ -1459,7 +1459,7 @@ static int rgb_attr_show(void)
 	index = drvdata.rgb_profile + 3;
 
 	return rgb_cfg_call(drvdata.hdev, GET_RGB_CFG, index, NULL, 0);
-};
+}
 
 static ssize_t rgb_effect_store(struct device *dev,
 				struct device_attribute *attr, const char *buf,
@@ -1489,7 +1489,7 @@ static ssize_t rgb_effect_store(struct device *dev,
 
 	drvdata.rgb_effect = effect;
 	return count;
-};
+}
 
 static ssize_t rgb_effect_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
@@ -1555,7 +1555,7 @@ static ssize_t rgb_speed_store(struct device *dev,
 	drvdata.rgb_speed = val;
 
 	return count;
-};
+}
 
 static ssize_t rgb_speed_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
@@ -1599,7 +1599,7 @@ static ssize_t rgb_mode_store(struct device *dev, struct device_attribute *attr,
 	drvdata.rgb_mode = val;
 
 	return count;
-};
+}
 
 static ssize_t rgb_mode_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
@@ -1614,7 +1614,7 @@ static ssize_t rgb_mode_show(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	return sysfs_emit(buf, "%s\n", rgb_mode_text[drvdata.rgb_mode]);
-};
+}
 
 static ssize_t rgb_mode_index_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
@@ -1653,7 +1653,7 @@ static ssize_t rgb_profile_store(struct device *dev,
 	drvdata.rgb_profile = val;
 
 	return count;
-};
+}
 
 static ssize_t rgb_profile_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -1668,7 +1668,7 @@ static ssize_t rgb_profile_show(struct device *dev,
 		return -EINVAL;
 
 	return sysfs_emit(buf, "%hhu\n", drvdata.rgb_profile);
-};
+}
 
 static ssize_t rgb_profile_range_show(struct device *dev,
 				      struct device_attribute *attr, char *buf)
@@ -1707,7 +1707,7 @@ static void hid_go_brightness_set(struct led_classdev *led_cdev,
 		break;
 	default:
 		dev_err(led_cdev->dev, "Failed to write RGB profile: %i\n", ret);
-	};
+	}
 }
 
 #define LEGO_DEVICE_ATTR_RW(_name, _attrname, _dtype, _rtype, _group)         \
-- 
2.53.0

