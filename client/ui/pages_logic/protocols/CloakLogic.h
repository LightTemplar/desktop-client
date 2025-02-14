#ifndef CLOAK_LOGIC_H
#define CLOAK_LOGIC_H

#include "PageProtocolLogicBase.h"

class UiLogic;

class CloakLogic : public PageProtocolLogicBase
{
    Q_OBJECT

    AUTO_PROPERTY(QString, comboBoxCipherText)
    AUTO_PROPERTY(QString, lineEditSiteText)
    AUTO_PROPERTY(QString, lineEditPortText)
    AUTO_PROPERTY(bool, pushButtonSaveVisible)
    AUTO_PROPERTY(bool, progressBarResetVisible)
    AUTO_PROPERTY(bool, lineEditPortEnabled)
    AUTO_PROPERTY(bool, pageEnabled)
    AUTO_PROPERTY(bool, labelInfoVisible)
    AUTO_PROPERTY(QString, labelInfoText)
    AUTO_PROPERTY(int, progressBarResetValue)
    AUTO_PROPERTY(int, progressBarResetMaximium)

public:
    Q_INVOKABLE void onPushButtonSaveClicked();

public:
    explicit CloakLogic(UiLogic *uiLogic, QObject *parent = nullptr);
    ~CloakLogic() = default;

    void updateProtocolPage (const QJsonObject &ckConfig, DockerContainer container, bool haveAuthData) override;
    QJsonObject getProtocolConfigFromPage(QJsonObject oldConfig) override;

private:
    Settings m_settings;
    UiLogic *m_uiLogic;

};
#endif // CLOAK_LOGIC_H
